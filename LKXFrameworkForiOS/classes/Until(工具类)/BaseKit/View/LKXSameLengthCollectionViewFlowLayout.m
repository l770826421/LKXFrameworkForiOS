//
//  LKXSameLengthCollectionViewFlowLayout.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/6/7.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXSameLengthCollectionViewFlowLayout.h"

@implementation LKXSameLengthCollectionViewFlowLayout

/**
 *  @author 刘克邪
 *
 *  @brief  重写该方法,保证Item的间距InteritemSpacing是等长的
 *
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *spaces = [super layoutAttributesForElementsInRect:rect];
    NSInteger maximumSpacing = self.minimumInteritemSpacing;
    
    for (int i = 1; i < spaces.count; i++) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = spaces[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = spaces[i - 1];
//        if (prevLayoutAttributes.representedElementKind || currentLayoutAttributes.representedElementKind) {
//            continue;
//        }
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        
        //根据  maximumInteritemSpacing 计算出的新的 x 位置
        CGFloat targetX = origin + maximumSpacing;
        
        if (CGRectGetMinX(currentLayoutAttributes.frame) > targetX) {
            // 换行时不调整
            if (targetX + CGRectGetWidth(currentLayoutAttributes.frame) < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = targetX;
                currentLayoutAttributes.frame = frame;
            }
        }
        
    }
    return spaces;
}

@end
