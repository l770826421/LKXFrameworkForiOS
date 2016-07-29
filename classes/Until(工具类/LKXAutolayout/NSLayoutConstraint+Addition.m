//
//  NSLayoutConstraint+Addition.m
//  XGMEport
//
//  Created by lkx on 16/3/23.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "NSLayoutConstraint+Addition.h"

@implementation NSLayoutConstraint (Addition)

/**
 *  @author 刘克邪
 *
 *  @brief  UIScrollView的autolayout,因为宽度不会适配self.view,所以写死
 *
 */
+ (NSArray *)lkx_constraintsWithScroll:(UIScrollView *)scroll {
    NSMutableArray *arr = [NSMutableArray array];
    
    NSString *vfl = @"V:|-0-[scroll]-0-|";
    NSDictionary *views = NSDictionaryOfVariableBindings(scroll);
    NSArray *arr_vertical = [NSLayoutConstraint constraintsWithVisualFormat:vfl
                                                                    options:0
                                                                    metrics:nil
                                                                      views:views];
    [arr addObjectsFromArray:arr_vertical];
    
    vfl = @"H:|-0-[scroll(==width)]-0-|";
    NSDictionary *metrics = @{@"width" : @(Dev_ScreenWidth)};
    NSArray *arr_horizontal = [NSLayoutConstraint constraintsWithVisualFormat:vfl
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views];
    [arr addObjectsFromArray:arr_horizontal];
    
    return arr;
}

/**
 *  @author 刘克邪
 *
 *  @brief  item相对父视图布局铺满
 *
 */
+ (NSArray *)lkx_constraintsWithItem:(id)item {
    return [self lkx_constraintsWithItem:item edgeInsets:UIEdgeInsetsZero];
}

/**
 *  @author 刘克邪
 *
 *  @brief  item相对父视图布局
 *
 *  @param item       item
 *  @param edgeInsets item相对符视图的偏距
 *
 */
+ (NSArray *)lkx_constraintsWithItem:(id)item edgeInsets:(UIEdgeInsets)edgeInsets {
    CGFloat top = edgeInsets.top;
    CGFloat leading = edgeInsets.left;
    CGFloat bottom = edgeInsets.bottom;
    CGFloat trailing = edgeInsets.right;
    
    NSArray *arr_horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[item]-trailing-|" options:0 metrics:@{@"leading":@(leading), @"trailing":@(trailing)} views:NSDictionaryOfVariableBindings(item)];
    NSArray *arr_vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[item]-bottom-|" options:0 metrics:@{@"top":@(top), @"bottom":@(bottom)} views:NSDictionaryOfVariableBindings(item)];
    
    NSMutableArray *arr_constraints = [NSMutableArray array];
    [arr_constraints addObjectsFromArray:arr_horizontal];
    [arr_constraints addObjectsFromArray:arr_vertical];
    return arr_constraints;
}

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
+ (NSArray *)lkx_constraintsTopWithItem:(id)item top:(CGFloat)top horizontalSpace:(CGFloat)horizontal hegiht:(CGFloat)height {
    NSMutableArray *constraints = [NSMutableArray array];
    
    NSArray *arr_horizontal = [NSLayoutConstraint lkx_constraintsHorizontalWithItem:item];
    [constraints addObjectsFromArray:arr_horizontal];
    NSArray *arr_vertical = [NSLayoutConstraint lkx_constraintsVerticalTopWithItem:item top:top height:height];
    [constraints addObjectsFromArray:arr_vertical];
    
    return constraints;
}

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
+ (NSArray *)lkx_constraintsBottomWithItem:(id)item bottom:(CGFloat)bottom horizontalSpace:(CGFloat)horizontal hegiht:(CGFloat)height {
    NSMutableArray *constraints = [NSMutableArray array];
    
    NSArray *arr_horizontal = [NSLayoutConstraint lkx_constraintsHorizontalWithItem:item space:horizontal];
    [constraints addObjectsFromArray:arr_horizontal];
    NSArray *arr_vertical = [NSLayoutConstraint lkx_constraintsVerticalBottomWithItem:item bottom:bottom height:height];
    [constraints addObjectsFromArray:arr_vertical];
    
    return constraints;
}

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
+ (NSArray *)lkx_constraintsBottomWithItem:(id)item bottom:(CGFloat)bottom leading:(CGFloat)leading trailing:(CGFloat)trailing hegiht:(CGFloat)height {
    NSMutableArray *constraints = [NSMutableArray array];
    
    NSArray *arr_horizontal = [NSLayoutConstraint lkx_constraintsHorizontalWithItem:item leading:leading trailing:trailing];
    [constraints addObjectsFromArray:arr_horizontal];
    NSArray *arr_vertical = [NSLayoutConstraint lkx_constraintsVerticalBottomWithItem:item bottom:bottom height:height];
    [constraints addObjectsFromArray:arr_vertical];
    
    return constraints;
}

@end
