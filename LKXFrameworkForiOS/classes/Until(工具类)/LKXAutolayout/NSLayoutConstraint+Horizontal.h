//
//  NSLayoutConstraint+Horizontal.h
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author 刘克邪
 *
 *  @brief  水平Autolayout
 */
@interface NSLayoutConstraint (Horizontal)

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的宽
 *
 */
+ (NSLayoutConstraint *)lkx_constraintWidthWithItem:(id)item width:(CGFloat)width;

/**
 *  @author 刘克邪
 *
 *  @brief  设置item与superView的间距
 *
 */
+ (NSArray *)lkx_constraintsWidthCenterWithItem:(id)item space:(CGFloat)space;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一水平线上
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterXWithItem:(id)item toItem:(id)toItem;

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一水平线上偏移offset
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterXWithItem:(id)item toItem:(id)toItem offset:(CGFloat)offset;

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的leading和toItem一样
 *
 *  @param item      item
 *  @param toItem    toItem
 *
 */
+ (NSLayoutConstraint *)lkx_constraintLeadingSameWithItem:(id)item toItem:(id)toItem;

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的leading和toItem一样
 *
 *  @param item      item
 *  @param toItem    toItem
 *  @param constaint 偏移的位置
 *
 */
+ (NSLayoutConstraint *)lkx_constraintLeadingSameWithItem:(id)item toItem:(id)toItem constaint:(CGFloat)constaint;

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的trailing和toItem一样
 *
 *  @param item      item
 *  @param toItem    toItem
 *
 */
+ (NSLayoutConstraint *)lkx_constraintTrailingSameWithItem:(id)item toItem:(id)toItem;

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的trailing和toItem一样
 *
 *  @param item      item
 *  @param toItem    toItem
 *  @param constaint 偏移的位置
 *
 */
+ (NSLayoutConstraint *)lkx_constraintTrailingSameWithItem:(id)item toItem:(id)toItem constaint:(CGFloat)constaint;

/**
 *  @author 刘克邪
 *
 *  @brief  item对superView水平适应,宽度与superView一样大
 *
 *  @param item  需要适配的view
 *
 */
+ (NSArray *)lkx_constraintsHorizontalWithItem:(id)item;

/**
 *  @author 刘克邪
 *
 *  @brief  item对superView水平适应
 *
 *  @param item  需要适配的view
 *  @param space 左右间距
 *
 */
+ (NSArray *)lkx_constraintsHorizontalWithItem:(id)item space:(CGFloat)space;

/**
 *  @author 刘克邪
 *
 *  @brief  item对superView水平适应
 *
 *  @param item     需要适配的view
 *  @param leading  leading
 *  @param trailing trailing
 *
 */
+ (NSArray *)lkx_constraintsHorizontalWithItem:(id)item leading:(CGFloat)leading trailing:(CGFloat)trailing;

/**
 *  @author 刘克邪
 *
 *  @brief  leading布局
 *
 *  @param item    item
 *  @param leading item的leading
 *  @param width   item的宽度
 *
 */
+ (NSArray *)lkx_constraintsLeadingWithItem:(id)item leading:(CGFloat)leading width:(CGFloat)width;

/**
 *  @author 刘克邪
 *
 *  @brief  trailing布局
 *
 *  @param item    item
 *  @param leading item的trailing
 *  @param width   item的宽度
 *
 */
+ (NSArray *)lkx_constraintsTrailingWithItem:(id)item trailing:(CGFloat)trailing width:(CGFloat)width;

@end
