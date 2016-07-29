//
//  UIBarButtonItem+LKX.m
//  SLShop
//
//  Created by lkx on 16/5/24.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "UIBarButtonItem+LKX.h"
#import "LKXBarButton.h"

@implementation UIBarButtonItem (LKX)

/**
 *  @author 刘克邪
 *
 *  @brief  实例化一个UIBarButtonItem对象(没有高亮效果)
 *
 *  @param icon   图标
 *  @param target 响应对象
 *  @param action 响应方法
 *
 */
+ (instancetype)lkx_backBarItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action {
    return [self lkx_barItemWithIcon:icon size:CGSizeMake(20, 20) target:target action:action];
}

/**
 *  @author 刘克邪
 *
 *  @brief  实例化一个UIBarButtonItem对象(没有高亮效果)
 *
 *  @param icon   图标
 *  @param icon   图标大小
 *  @param target 响应对象
 *  @param action 响应方法
 *
 */
+ (instancetype)lkx_barItemWithIcon:(NSString *)icon size:(CGSize)size target:(id)target action:(SEL)action {
    BigBtn *backButton = [BigBtn buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(30, 30);
    }
    backButton.frame = (CGRect){{0, 0}, size};
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setShowsTouchWhenHighlighted:NO];
    [backButton addTarget:target
                   action:action
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return item;
}

/**
 *  @author 刘克邪
 *
 *  @brief  示例话一个UIBarButtonItem对象(高亮效果和选中效果一致)
 *
 *  @param icon         图标
 *  @param selectedIcon 选中图标
 *  @param target       响应对象
 *  @param action       响应方法
 *
 */
+ (instancetype)lkx_barItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon target:(id)target action:(SEL)action {
    BigBtn *rightBtn = [BigBtn buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (![NSString isEmptyWithString:icon]) {
        [rightBtn setImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                  forState:UIControlStateNormal];
    }
    
    if (![NSString isEmptyWithString:selectedIcon]) {
        [rightBtn setImage:[[UIImage imageNamed:selectedIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                  forState:UIControlStateSelected];
        
        [rightBtn setImage:[[UIImage imageNamed:selectedIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                  forState:UIControlStateHighlighted];
    }
    
    [rightBtn addTarget:target
                 action:action
       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    return item;
}

/**
 *  @author 刘克邪
 *
 *  @brief  实例化一个UIBarButtonItem对象
 *
 *  @param title          标题
 *  @param selectedTitle  选中标题
 *  @param target         响应对象
 *  @param action         响应方法
 *
 */
+ (instancetype)lkx_barItemWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action {
    BigBtn *rightBtn = [BigBtn buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [rightBtn setTitle:title forState:UIControlStateNormal];
    if (![NSString isEmptyWithString:selectedTitle]) {
        [rightBtn setTitle:selectedTitle forState:UIControlStateSelected];
    }
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:kFontSize_15];
    
    [rightBtn addTarget:target
                 action:action
       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    return item;
}


/**
 *  @author 刘克邪
 *
 *  @brief  示例话一个UIBarButtonItem对象(高亮效果和选中效果一致)
 *
 *  @param title        标题
 *  @param icon         图标
 *  @param selectedIcon 选中图标
 *  @param target       响应对象
 *  @param action       响应方法
 *
 */
+ (instancetype)lkx_barItemWithTitle:(NSString *)title icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon target:(id)target action:(SEL)action {
    LKXBarButton *rightBtn = [LKXBarButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [rightBtn setTitle:title
              forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    if (![NSString isEmptyWithString:icon]) {
        [rightBtn setImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                  forState:UIControlStateNormal];
    }
    
    if (![NSString isEmptyWithString:selectedIcon]) {
        [rightBtn setImage:[[UIImage imageNamed:selectedIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                  forState:UIControlStateSelected];
        
        [rightBtn setImage:[[UIImage imageNamed:selectedIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                  forState:UIControlStateHighlighted];
    }
    
    [rightBtn addTarget:target
                 action:action
       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    return item;
}


@end
