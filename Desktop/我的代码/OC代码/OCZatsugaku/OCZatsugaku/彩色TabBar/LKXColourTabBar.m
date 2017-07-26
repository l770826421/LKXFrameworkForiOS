//
//  LKXColourTabBar.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/26.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXColourTabBar.h"

@interface LKXColourTabBar () <UITabBarDelegate>

/** 彩色的view */
@property(nonatomic, weak) UIView *colourView;
/** 需要显色的部分 */
@property(nonatomic, strong) UIView *colourMaskView;

/** 前一个选中的index */
@property(nonatomic, assign) NSInteger previousIndex;
/** 现在选中的 */
@property(nonatomic, assign) NSInteger currentIndex;

@end

@implementation LKXColourTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self p_init];
}

- (void)p_init {
    [self p_setupColorView];
    [self p_setupMaskLayer];
}

/**
 设置每个item的背景颜色
 */
- (void)p_setupColorView {
    UIView *colorView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:colorView];
    self.colourView = colorView;
    [self sendSubviewToBack:colorView];
    
    CGFloat itemWidth = self.lkx_width / self.items.count;
    NSArray *itemColors = @[[UIColor redColor], [UIColor greenColor], [UIColor orangeColor], [UIColor yellowColor]];
    
    for (int i = 0; i < self.items.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, self.lkx_height)];
        view.backgroundColor = itemColors[i];
        [self.colourView addSubview:view];
    }
}

/**
 设置遮罩效果
 */
- (void)p_setupMaskLayer {
    CGFloat itemWidth = self.lkx_width / self.items.count;
    
    UIView *colorMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, self.lkx_height)];
    colorMaskView.backgroundColor = [UIColor blackColor];
    self.colourMaskView = colorMaskView;
    self.colourView.layer.mask = self.colourMaskView.layer;
}

/**
 items之间的切换动画
 */
- (void)p_animation {
    CGFloat itemWidth  = self.lkx_width / self.items.count;
    // 遮罩每次移动，都先会多出一部分，然后再到另一个index，这个变量用来设置多出的那部分的宽度
    CGFloat extraWidth = itemWidth / 4;
    CGRect scaleFrame = CGRectMake(CGRectGetMinX(self.colourMaskView.frame), 0, itemWidth + extraWidth, self.lkx_height);
    CGRect toFrame = CGRectMake(self.currentIndex * itemWidth, 0, itemWidth, self.lkx_height);
    
    if (self.previousIndex > self.currentIndex) {
        scaleFrame = CGRectMake(CGRectGetMinX(self.colourMaskView.frame) - extraWidth, 0, itemWidth + extraWidth, self.lkx_height);
    }
    
    // 动画分为两部分
    // 第一部分:遮罩线展开一部分
    // 第二部分:位移并缩小回原来的大小
    // 第一部分淡入，第二部分淡出
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.colourMaskView.frame = scaleFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{self.colourMaskView.frame = toFrame; }
                             completion:nil];
        }
    }];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.items indexOfObject:item];
    self.previousIndex = self.currentIndex;
    self.currentIndex = index;
    [self p_animation];
}

#pragma mark - Override
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemWidth = self.lkx_width / self.items.count;
    NSArray *subViews = self.colourView.subviews;
    self.colourMaskView.frame = CGRectMake(self.currentIndex * itemWidth, 0, itemWidth, self.lkx_height);
    for (int i = 0; i < subViews.count; i++) {
        UIView *view = subViews[i];
        view.frame = CGRectMake(itemWidth * i, 0, itemWidth, self.lkx_height);
    }
    
}

@end
