//
//  NSLayoutConstraint+Vertical.m
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "NSLayoutConstraint+Vertical.h"

@implementation NSLayoutConstraint (Vertical)

/**
 *  @author 刘克邪
 *
 *  @brief  设置item的高
 *
 */
+ (NSLayoutConstraint *)lkx_constraintHeightWithItem:(id)item height:(CGFloat)height {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
    return constraint;
}

/**
 *  @author 刘克邪
 *
 *  @brief  相对supperView顶部布局
 *
 *  @param item   需要适配的view
 *  @param height item的height
 *
 */
+ (NSArray *)lkx_constraintsVerticalTopWithItem:(id)item height:(CGFloat)height {
    return [self lkx_constraintsVerticalTopWithItem:item top:0 height:height];
}

/**
 *  @author 刘克邪
 *
 *  @brief  相对supperView顶部布局
 *
 *  @param item   需要适配的view
 *  @param item   顶部距离
 *  @param height item的height
 *
 */
+ (NSArray *)lkx_constraintsVerticalTopWithItem:(id)item top:(CGFloat)top height:(CGFloat)height {
    NSArray *arr_vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[item(==height)]" options:0 metrics:@{@"height":@(height), @"top":@(top)} views:NSDictionaryOfVariableBindings(item)];
    return arr_vertical;
}

/**
 *  @author 刘克邪
 *
 *  @brief  相对supperView顶部布局
 *
 *  @param item   需要适配的view
 *  @param height item的height
 *
 */
+ (NSArray *)lkx_constraintsVerticalBottomWithItem:(id)item height:(CGFloat)height {
    return [self lkx_constraintsVerticalBottomWithItem:item bottom:0 height:height];
}

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
+ (NSArray *)lkx_constraintsVerticalBottomWithItem:(id)item bottom:(CGFloat)bottom height:(CGFloat)height {
    NSArray *arr_vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[item(==height)]-bottom-|" options:0 metrics:@{@"height":@(height), @"bottom":@(bottom)} views:NSDictionaryOfVariableBindings(item)];
    return arr_vertical;
}

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一垂直线上
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterYWithItem:(id)item toItem:(id)toItem {
    return [self lkx_constraintCenterYWithItem:item toItem:toItem offset:0];
}

/**
 *  @author 刘克邪
 *
 *  @brief  item相对toItem在同一垂直线上偏移offset
 *
 */
+ (NSLayoutConstraint *)lkx_constraintCenterYWithItem:(id)item toItem:(id)toItem offset:(CGFloat)offset {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeCenterY multiplier:1 constant:offset];
    return constraint;
}

/**
 *  @author 刘克邪
 *
 *  @brief  item与父视图的top布局,间距为0
 *
 */
+ (NSLayoutConstraint *)lkx_constraintTopWithItem:(id)item {
    return [self lkx_constraintTopWithItem:item space:0];
}

/**
 *  @author 刘克邪
 *
 *  @brief  item与父视图的top布局,间距为space
 *
 */
+ (NSLayoutConstraint *)lkx_constraintTopWithItem:(id)item space:(CGFloat)space {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:space];
    return constraint;
}


@end
