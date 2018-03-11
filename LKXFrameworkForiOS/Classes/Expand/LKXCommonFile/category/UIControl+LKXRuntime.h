//
//  UIControl+LKXRuntime.h
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/9/17.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 防止连续点击响应的问题
 */
@interface UIControl (LKXRuntime)

// 点击之后每过lkx_acceptEventInterval点击,该UIControl才有效
@property (nonatomic, assign) NSTimeInterval lkx_acceptEventInterval;
@property (nonatomic, assign) BOOL lkx_ignoreEvent; // 是否忽略事件

@end
