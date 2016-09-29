//
//  NSLayoutConstraint+Vertical.h
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author 刘克邪
 *
 *  @brief  垂直Autolayout
 */
@interface NSLayoutConstraint (Vertical)

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的高
 *
 */
+ (NSLayoutConstraint *)lkx_constraintHeightWithItem:(id)item height:(CGFloat)height;

/**
 *  @author 刘克邪
 *
 *  @brief  相对supperView顶部布局
 *
 *  @param item   需要适配的view
 *  @param height item的height
 *
 */
+ (NSArray *)lkx_constraintsVerticalTopWithItem:(id)item height:(CGFloat)height;

/**
 *  @author 刘克邪
 *
 *  @brief  相对supperView顶部布局
 *
 *  @param item   需要适配的view
 *  @param height item的height
 *
 */
+ (NSArray *)lkx_constraintsVerticalTopWithItem:(id)item top:(CGFloat)top height:(CGFloat)height;

/**
 *  @author 刘克邪
 *
 *  @brief  相对supperView顶部布局
 *
 *  @param item   需要适配的view
 *  @param height item的height
 *
 */
+ (NSArray *)lkx_constraintsVerticalBottomWithItem:(id)item height:(CGFloat)height;

/**
 *  @author 刘克邪
 *
 *  @brief  相对supperView顶部布局
 *
 *  @param item   需要适配的view
 *  @param bottom 底部距离
 *  @param height item的height
 *
 */
+ (NSArray *)lkx_constraintsVerticalBottomWithItem:(id)item bottom:(CGFloat)bottom height:(CGFloat)height;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一垂直线上
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterYWithItem:(id)item toItem:(id)toItem;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一垂直线上偏移offset
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterYWithItem:(id)item toItem:(id)toItem offset:(CGFloat)offset;

/**
 *  @author 刘克邪
 *
 *  @brief  item与父视图的top布局,间距为0
 *
 */
+ (NSLayoutConstraint *)lkx_constraintTopWithItem:(id)item;

/**
 *  @author 刘克邪
 *
 *  @brief  item与父视图的top布局,间距为space
 *
 */
+ (NSLayoutConstraint *)lkx_constraintTopWithItem:(id)item space:(CGFloat)space;

@end
