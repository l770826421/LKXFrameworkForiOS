//
//  LKXLocalNotificationTool.h
//  OCZatsugaku
//
//  Created by lkx on 2017/6/23.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 本地通知工具 iOS version10.0以前
 */
@interface LKXLocalNotificationTool : NSObject

+ (instancetype)shareLocalNotificationTool;

/**
 注册本地通知
 
 @param interval 相对现在的时间的差值
 @param body 弹出警告框中的内容
 @param soundName 触发时的声音
 @param calendarUnit 触发频率
 @param badge 需要在App icon上显示的未读通知数（设置为1时，多个通知未读，系统会自动加1，如果不需要显示未读数，这里可以设置0）
 @param userInfo 其他信息
 */
- (void)localNotificationWithFireDate:(NSTimeInterval)interval
                            alertBody:(NSString *)body
                             soudName:(NSString *)soundName
                       repeatInterval:(NSCalendarUnit)calendarUnit
                                badge:(NSInteger)badge
                             userInfo:(NSDictionary *)userInfo;

/**
 移除本地通知
 */
- (void)cancelAllLocalNotification;

/**
 根据指定的键值对移除本地通知
 */
- (void)cancelLocalNotifiationWithIdentifier:(NSString *)identifier value:(NSString *)value;

@end
