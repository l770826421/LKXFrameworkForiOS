//
//  LKXUNLocalNotificationTool.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/23.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXUNLocalNotificationTool.h"
#import <UIKit/UIKit.h>

@interface LKXUNLocalNotificationTool () <UNUserNotificationCenterDelegate>
{
    UNUserNotificationCenter *center;
}

@end

@implementation LKXUNLocalNotificationTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static LKXUNLocalNotificationTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        /**
         获取授权设置信息
         */
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusDenied:
                    NSLog(@"用户未授权");
                    break;
                case UNAuthorizationStatusNotDetermined:
                    NSLog(@"用户已没有做出选择");
                    break;
                default:
                    NSLog(@"用户已授权");
                    break;
            }
        }];
    }
    return self;
}

/**
 单例
 */
+ (instancetype)shareLocalNotificationTool {
    LKXUNLocalNotificationTool *instance = [[LKXUNLocalNotificationTool alloc] init];
    return instance;
}

/**
    请求授权,一般在didFinishLaunchingWithOptions:调用
 */
- (void)registerLocalNotification {
    [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            NSLog(@"注册本地通知失败:%@", error);
        } else {
            NSLog(@"注册成功");
        }
    }];
}

#pragma mark - 发送本地通知
/**
 创建本地通知，在多少秒后触发

 @param title 主标题
 @param subTitle 副标题
 @param badge 增加的application通知数
 @param body 主要信息
 @param interval interval后触发
 @param identifier 标识
 */
- (void)localNotificationWithTitle:(NSString *)title
                         subTtitle:(NSString *)subTitle
                             badge:(NSInteger)badge
                              body:(NSString *)body
               timeIntervalTrigger:(NSTimeInterval)interval
                           repeats:(BOOL)repeats
                        identifier:(NSString *)identifier {
    // 设置触发时间
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
    [self localNotificationWithTitle:title
                           subTtitle:subTitle
                               badge:badge
                                body:body
                             trigger:trigger
                          identifier:identifier];
}

/**
 创建本地通知，在某个时间触发
 
 @param title 主标题
 @param subTitle 副标题
 @param badge 增加的application通知数
 @param body 主要信息
 @param dateComponents 触发时间
 @param repeats 是否重复触发
 @param identifier 标识
 */
- (void)localNotificationWithTitle:(NSString *)title
                         subTtitle:(NSString *)subTitle
                             badge:(NSInteger)badge
                              body:(NSString *)body
                       dateTrigger:(NSDateComponents *)dateComponents
                           repeats:(BOOL)repeats
                        identifier:(NSString *)identifier {
    // 设置触发时间
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:repeats];
    [self localNotificationWithTitle:title
                           subTtitle:subTitle
                               badge:badge
                                body:body
                             trigger:trigger
                          identifier:identifier];
}

/**
 创建本地通知，在用户进入或者离开某个区域时触发
 
 @param title 主标题
 @param subTitle 副标题
 @param badge 增加的application通知数
 @param body 主要信息
 @param region 触发区域
 @param repeats 是否重复触发
 @param identifier 标识
 */
- (void)localNotificationWithTitle:(NSString *)title
                         subTtitle:(NSString *)subTitle
                             badge:(NSInteger)badge
                              body:(NSString *)body
                     regionTrigger:(CLRegion *)region
                           repeats:(BOOL)repeats
                        identifier:(NSString *)identifier {
    // 设置触发时间
    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:repeats];
    [self localNotificationWithTitle:title
                           subTtitle:subTitle
                               badge:badge
                                body:body
                             trigger:trigger
                          identifier:identifier];
}

/**
 创建本地通知
 
 @param title 主标题
 @param subTitle 副标题
 @param badge 增加的application通知数
 @param body 主要信息
 @param trigger 触发时间
 @param identifier 标识
 */
- (void)localNotificationWithTitle:(NSString *)title
                         subTtitle:(NSString *)subTitle
                             badge:(NSInteger)badge
                              body:(NSString *)body
                           trigger:(UNNotificationTrigger *)trigger
                        identifier:(NSString *)identifier {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    content.subtitle = [NSString localizedUserNotificationStringForKey:subTitle arguments:nil];
    content.badge = @(badge + [UIApplication sharedApplication].applicationIconBadgeNumber);
    content.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    [self localNotificationWithContent:content
                               trigger:trigger
                            identifier:identifier];
}

/**
 创建本地通知
 
 @param content 本地通知
 @param trigger 触发时间
 @param identifier 标识
 */
- (void)localNotificationWithContent:(UNNotificationContent *)content
                           trigger:(UNNotificationTrigger *)trigger
                        identifier:(NSString *)identifier {
    // 创建发送一个请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"添加本地推送请求失败: %@", error);
        } else {
            NSLog(@"添加本地推送请求成功");
        }
    }];
}

#pragma mark - 其他操作
/**
 移除还未展示的通知
 
 @param identifier 未展示的通知的Identifier
 */
- (void)removePendingNotificationRequestWithIdentifier:(NSString *)identifier {
    [self removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

/**
 移除还未展示的通知

 @param identifiers 未展示的通知的Identifier 数组
 */
- (void)removePendingNotificationRequestsWithIdentifiers:(NSArray <NSString *> *)identifiers {
    [center removePendingNotificationRequestsWithIdentifiers:identifiers];
}

/**
 移除所有未展示的本地通知
 */
- (void)removeAllPendingNotificationRequests {
    [center removeAllPendingNotificationRequests];
}

- (void)getDeliveredNotificationWithIdentifiersBlock:(void (^)(NSArray <NSString *> * identifiers))identifiersBlock {
    [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        NSMutableArray <NSString *> *identifiers = [NSMutableArray array];
        for (UNNotification *notification in notifications) {
            [identifiers addObject:notification.request.identifier];
        }
        identifiersBlock(identifiers);
    }];
}

/**
 移除已经展示过的通知
 
 @param identifier 展示过的通知的Identifier
 */
- (void)removeDeliveredNotificationWithIdentifier:(NSString *)identifier {
    [self removeDeliveredNotificationsWithIdentifiers:@[identifier]];
}

/**
 移除已经展示过的通知

 @param identifiers 展示过的通知的Identifier数组
 */
- (void)removeDeliveredNotificationsWithIdentifiers:(NSArray <NSString *> *)identifiers {
    [center removeDeliveredNotificationsWithIdentifiers:identifiers];
}

/**
 移除所有已经展示过的通知
 */
- (void)removeAllDeliveredNotifications {
    [center removeAllDeliveredNotifications];
}

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"userInfo == %@", response.notification.request.content.userInfo);
}

@end
