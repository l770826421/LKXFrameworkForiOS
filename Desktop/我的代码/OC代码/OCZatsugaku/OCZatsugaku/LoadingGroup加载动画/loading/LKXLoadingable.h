//
//  LKXLoadingable.h
//  OCZatsugaku
//
//  Created by lkx on 2017/6/28.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LKXLoadingable <NSObject>

/** 是否在加载 */
@property(nonatomic, assign, getter=isLoading) BOOL loading;

/**
 开始加载
 */
- (void)startLoading;

/**
 结束加载

 @param finish 结束加载后的操作
 */
- (void)stopLoading:(void (^)())finish;

/** 动画时间长 */
@property(nonatomic, assign, readonly) NSTimeInterval animationDuration;
/** 线宽 */
@property(nonatomic, assign, readonly) CGFloat lineWidth;
/** 颜色 */
@property(nonatomic, strong, readonly) UIColor *loadingTintColor;


@end
