//
//  UIBarButtonItem+LKX.h
//  SLShop
//
//  Created by lkx on 16/5/24.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  @author 刘克邪
 *
 *  @brief  UIBarButtonItem的扩展类
 */
@interface UIBarButtonItem (LKXCategory)
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
+ (instancetype)lkx_backBarItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;

/**
 *  @author 刘克邪
 *
 *  @brief  实例化一个UIBarButtonItem对象(没有高亮效果)
 *
 *  @param icon   图标
 *  @param size   图标大小
 *  @param target 响应对象
 *  @param action 响应方法
 *
 */
+ (instancetype)lkx_barItemWithIcon:(NSString *)icon size:(CGSize)size target:(id)target action:(SEL)action;

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
+ (instancetype)lkx_barItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon target:(id)target action:(SEL)action;

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
+ (instancetype)lkx_barItemWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action;

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
+ (instancetype)lkx_barItemWithTitle:(NSString *)title icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon target:(id)target action:(SEL)action;

@end
