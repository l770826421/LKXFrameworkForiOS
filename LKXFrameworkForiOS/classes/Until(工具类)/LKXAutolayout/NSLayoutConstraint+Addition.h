//
//  NSLayoutConstraint+Addition.h
//  XGMEport
//
//  Created by lkx on 16/3/23.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKXLayoutContraint.h"

/**
 *  @author 刘克邪
 *
 *  @brief  autolayout其他布局扩展
 */
@interface NSLayoutConstraint (Addition)

/**
 *  @author 刘克邪
 *
 *  @brief  UIScrollView的autolayout,因为宽度不会适配self.view,所以写死
 *
 */
+ (NSArray *)lkx_constraintsWithScroll:(UIScrollView *)scroll;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对父视图布局铺满
 *
 */
+ (NSArray *)lkx_constraintsWithItem:(id)item;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对父视图布局
 *
 *  @param item       item
 *  @param edgeInsets item相对符视图的偏距
 *
 */
+ (NSArray *)lkx_constraintsWithItem:(id)item edgeInsets:(UIEdgeInsets)edgeInsets;


/**
 *  @author 刘克邪
 *
 *  @brief  item相对父视图顶部布局
 *
 *  @param item       item
 *  @param top        顶部距离
 *  @param horizontal leading and traniling
 *  @param height     item的height
 *
 */
+ (NSArray *)lkx_constraintsTopWithItem:(id)item top:(CGFloat)top horizontalSpace:(CGFloat)horizontal hegiht:(CGFloat)height;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对父视图顶部布局
 *
 *  @param item       item
 *  @param top        顶部距离
 *  @param horizontal leading and traniling
 *  @param height     item的height
 *
 */
+ (NSArray *)lkx_constraintsBottomWithItem:(id)item bottom:(CGFloat)bottom horizontalSpace:(CGFloat)horizontal hegiht:(CGFloat)height;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对父视图顶部布局
 *
 *  @param item       item
 *  @param top        顶部距离
 *  @param leading    leading
 *  @param trailing   trailing
 *  @param height     item的height
 *
 */
+ (NSArray *)lkx_constraintsBottomWithItem:(id)item bottom:(CGFloat)bottom leading:(CGFloat)leading trailing:(CGFloat)trailing hegiht:(CGFloat)height;

@end
