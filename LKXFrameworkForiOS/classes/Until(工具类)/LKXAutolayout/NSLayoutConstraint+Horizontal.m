//
//  NSLayoutConstraint+Horizontal.m
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "NSLayoutConstraint+Horizontal.h"

@implementation NSLayoutConstraint (Horizontal)

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的宽
 *
 */
+ (NSLayoutConstraint *)lkx_constraintWidthWithItem:(id)item width:(CGFloat)width {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:width];
    return constraint;
}

/**
 *  @author 刘克邪
 *
 *  @brief  设置item与superView的间距
 *
 */
+ (NSArray *)lkx_constraintsWidthCenterWithItem:(id)item space:(CGFloat)space {
    NSArray *arr_horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-space-[item]-space-|" options:0 metrics:@{@"space":@(space)} views:NSDictionaryOfVariableBindings(item)];
    return arr_horizontal;
}

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一水平线上
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterXWithItem:(id)item toItem:(id)toItem {
    return [self lkx_constraintCenterXWithItem:item toItem:toItem offset:0];
}

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一水平线上偏移offset
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterXWithItem:(id)item toItem:(id)toItem offset:(CGFloat)offset {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeCenterX multiplier:1 constant:offset];
    return constraint;
}

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的leading和toItem一样
 *
 *  @param item      item
 *  @param toItem    toItem
 *
 */
+ (NSLayoutConstraint *)lkx_constraintLeadingSameWithItem:(id)item toItem:(id)toItem {
    return [self lkx_constraintLeadingSameWithItem:item toItem:toItem constaint:0];
}

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
+ (NSLayoutConstraint *)lkx_constraintLeadingSameWithItem:(id)item toItem:(id)toItem constaint:(CGFloat)constaint {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeLeading multiplier:1 constant:constaint];
    return constraint;
}

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的trailing和toItem一样
 *
 *  @param item      item
 *  @param toItem    toItem
 *
 */
+ (NSLayoutConstraint *)lkx_constraintTrailingSameWithItem:(id)item toItem:(id)toItem {
    return [self lkx_constraintTrailingSameWithItem:item toItem:toItem constaint:0];
}

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
+ (NSLayoutConstraint *)lkx_constraintTrailingSameWithItem:(id)item toItem:(id)toItem constaint:(CGFloat)constaint {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeTrailing multiplier:1 constant:constaint];
    return constraint;
}

/**
 *  @author 刘克邪
 *
 *  @brief  item对superView水平适应,宽度与superView一样大
 *
 *  @param item  需要适配的view
 *
 */
+ (NSArray *)lkx_constraintsHorizontalWithItem:(id)item {
    return [self lkx_constraintsHorizontalWithItem:item space:0];
}

/**
 *  @author 刘克邪
 *
 *  @brief  item对superView水平适应
 *
 *  @param item  需要适配的view
 *  @param space 左右间距
 *
 */
+ (NSArray *)lkx_constraintsHorizontalWithItem:(id)item space:(CGFloat)space {
//    NSArray *arr_horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-space-[item]-space-|" options:0 metrics:@{@"space":@(space)} views:NSDictionaryOfVariableBindings(item)];
    return [self lkx_constraintsHorizontalWithItem:item leading:space trailing:space];
}

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
+ (NSArray *)lkx_constraintsHorizontalWithItem:(id)item leading:(CGFloat)leading trailing:(CGFloat)trailing {
    NSArray *arr_horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[item]-trailing-|" options:0 metrics:@{@"leading":@(leading), @"trailing":@(trailing)} views:NSDictionaryOfVariableBindings(item)];
    return arr_horizontal;
}

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
+ (NSArray *)lkx_constraintsLeadingWithItem:(id)item leading:(CGFloat)leading width:(CGFloat)width {
    NSArray *arr_leading = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[item(==width)]" options:0 metrics:@{@"leading" : @(leading), @"width" : @(width)} views:NSDictionaryOfVariableBindings(item)];
    return arr_leading;
}

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
+ (NSArray *)lkx_constraintsTrailingWithItem:(id)item trailing:(CGFloat)trailing width:(CGFloat)width {
    NSArray *arr_leading = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[item(==width)]-trailing-|" options:0 metrics:@{@"trailing" : @(trailing), @"width" : @(width)} views:NSDictionaryOfVariableBindings(item)];
    return arr_leading;
}

@end
