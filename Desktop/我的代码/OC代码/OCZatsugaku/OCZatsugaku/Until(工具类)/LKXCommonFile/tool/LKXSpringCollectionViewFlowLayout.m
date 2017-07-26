//
//  LKXSpringCollectionViewFlowLayout.m
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/5/22.
//  Copyright (c) 2015年 刘克邪. All rights reserved.
//

#import "LKXSpringCollectionViewFlowLayout.h"

@interface LKXSpringCollectionViewFlowLayout()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation LKXSpringCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _springDamping = 0.5;
        _springFrequency = 0.8;
        _resistanceFactor = 500;
    }
    return self;
}

-(void)setSpringDamping:(CGFloat)springDamping {
    if (springDamping >= 0 && _springDamping != springDamping) {
        _springDamping = springDamping;
        for (UIAttachmentBehavior *spring in _animator.behaviors) {
            spring.damping = _springDamping;
        }
    }
}

-(void)setSpringFrequency:(CGFloat)springFrequency {
    if (springFrequency >= 0 && _springFrequency != springFrequency) {
        _springFrequency = springFrequency;
        for (UIAttachmentBehavior *spring in _animator.behaviors) {
            spring.frequency = _springFrequency;
        }
    }
}

- (void)prepareLayout
{
    [super prepareLayout];
    if (!_animator)
    {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *item in items)
        {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item
                                                                     attachedToAnchor:item.center];
            spring.length = 0;
            spring.damping = self.springDamping;
            spring.frequency = self.springFrequency;
            
            [_animator addBehavior:spring];
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [_animator itemsInRect:rect];
    return arr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attri = [_animator layoutAttributesForCellAtIndexPath:indexPath];
    return  attri;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    //get the touch point
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in _animator.behaviors)
    {
        CGPoint anchorPoint = spring.anchorPoint;
        
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / self.resistanceFactor;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[spring.items firstObject];
        CGPoint center = item.center;
        
        center.y += (scrollDelta > 0) ? MIN(scrollDelta, scrollDelta * scrollResistance)
                                      : MAX(scrollDelta, scrollDelta * scrollResistance);
        item.center = center;
        
        [_animator updateItemUsingCurrentState:item];
    }
    return NO;
}

@end
