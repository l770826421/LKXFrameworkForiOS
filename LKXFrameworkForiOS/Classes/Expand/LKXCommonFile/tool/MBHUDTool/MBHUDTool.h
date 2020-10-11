//
//  MBHUDTool.h
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/4/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SingletonMacro.h"

#import <MBProgressHUD/MBProgressHUD.h>

UIKIT_EXTERN const CGFloat kMBHUDDelay;

@interface MBHUDTool : NSObject <MBProgressHUDDelegate>
single_interface(MBHUDTool)

/** MBProgressHUD实例化对象,只初始化一次 */
@property(nonatomic, strong, readonly) MBProgressHUD *mbHud;

/**
 显示提示文字
 */
- (void)showHUDWithText:(NSString *)text
             detailText:(NSString *)detailText;

/**
 显示提示文字
 */
- (void)showHUDWithText:(NSString *)text
             detailText:(NSString *)detailText
                  delay:(NSTimeInterval)delay;

/**
 显示一个数据加载的动画,小菊花(默认提示语加载中)
 */
- (void)showActivityIndicatorWithText:(NSString *)text
                           detailText:(NSString *)detailText;

//显示一个圆环加载
- (void)showAnnularWithText:(NSString *)text
                 detailText:(NSString *)detailText;

/**
 显示一个自定义的提示view
 
 @param view 提示view,传入的view的frame要确定
 */
- (void)showCustomView:(UIView *)view
                 delay:(NSTimeInterval)delay;

//一个横向的进度条
- (void)showHorizontalBarWithText:(NSString *)text
                       detailText:(NSString *)detailText;

//显示一个圆圈加载
- (void)showDeterminateWithText:(NSString *)text
                     detailText:(NSString *)detailText;

//隐藏一处MBProgressHUD
- (void)hideMBHUD:(BOOL)animated;

//判断MBHUD是否存在
- (BOOL)isShow;

// 判断MBHUD是否隐藏
- (BOOL)isHidden;

#pragma mark - 非MBProgressHUD
/**
 *  显示一些信息在2.5秒后消失
 *
 *  @param tips 显示的字符串
 */
+ (void)messageLabelTips:(NSString *)tips;

@end
