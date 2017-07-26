//
//  LKXLocalNotificationTool.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/23.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXLocalNotificationTool.h"
#import <UIKit/UIKit.h>

@interface LKXLocalNotificationTool ()
{
    UILocalNotification *localNotification;
}

@end

@implementation LKXLocalNotificationTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static LKXLocalNotificationTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        localNotification = [[UILocalNotification alloc] init];
    }
    return self;
}

+ (instancetype)shareLocalNotificationTool {
    LKXLocalNotificationTool *instance = [[LKXLocalNotificationTool alloc] init];
    return instance;
}

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
                             userInfo:(NSDictionary *)userInfo {
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    localNotification.alertBody = body;
    localNotification.soundName = soundName;
    localNotification.repeatInterval = calendarUnit;
    localNotification.applicationIconBadgeNumber += badge;
    localNotification.userInfo = userInfo;
    
    // 注册本地通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

/**
 移除本地通知
 */
- (void)cancelAllLocalNotification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

/**
 根据指定的键值对移除本地通知
 */
- (void)cancelLocalNotifiationWithIdentifier:(NSString *)identifier value:(NSString *)value {
    NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *currentLocalNotification in notifications) {
        if ([[currentLocalNotification.userInfo objectForKey:identifier] isEqualToString:value]) {
            [[UIApplication sharedApplication] cancelLocalNotification:currentLocalNotification];
            break;
        }
    }
}

@end
