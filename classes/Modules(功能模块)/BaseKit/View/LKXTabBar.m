//
//  LKXTabBar.m
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTabBar.h"
#import "LKXTabBarButton.h"

@interface LKXTabBar()

/** 全部的自定barButton */
@property (nonatomic, strong) NSMutableArray *barButtons;
@property (nonatomic, weak) LKXTabBarButton *selectedBtn;

@end

@implementation LKXTabBar

+ (instancetype)tabBar {
    LKXTabBar *tabBar = [[LKXTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    return tabBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    NSInteger count = self.subviews.count;
    CGFloat width = self.Width / count;
    CGFloat height = self.Height;
    for (int i = 0; i < count; i++) {
        LKXTabBarButton *btn = self.subviews[i];
        btn.tag = i;
        btn.frame = CGRectMake(width * i, 0, width, height);
        
        // 自动选中第一个button
        if (i == 0) {
            [self btnActionClick:btn];
        }
    }
}

- (NSMutableArray *)barButtons {
    if (_barButtons == nil) {
        _barButtons = [NSMutableArray array];
    }
    return _barButtons;
}

/**
 *  @author 刘克邪
 *
 *  @brief  添加选项卡
 */
- (void)addTabBarButton:(UITabBarItem *)item {
    LKXTabBarButton *tabBarButton = [[LKXTabBarButton alloc] initWithFrame:CGRectZero];
    tabBarButton.item = item;
    [tabBarButton addTarget:self action:@selector(btnActionClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarButton];
    [self.barButtons addObject:tabBarButton];
}

#pragma mark - 控件响应方法
- (void)btnActionClick:(LKXTabBarButton *)button {
    NSInteger formIndex = 0;
    if (self.selectedBtn) {
        self.selectedBtn.selected = NO;
        formIndex = self.selectedBtn.tag;
    }
    
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedFormIndex:toIndex:)]) {
        [self.delegate tabBar:self didSelectedFormIndex:formIndex toIndex:button.tag];
    }
}

/**
 *  @author 刘克邪
 *
 *  @brief  手动设置选中的item
 *
 *  @param index item的索引
 */
- (void)selectIndex:(NSUInteger)index {
    LKXTabBarButton *btn = self.barButtons[index];
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

@end
