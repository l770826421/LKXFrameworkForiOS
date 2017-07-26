//
//  LKXUNLocalNotificationTool.h
//  OCZatsugaku
//
//  Created by lkx on 2017/6/23.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

/**
  本地通知工具 iOS version10.0及以后
 */
@interface LKXUNLocalNotificationTool : NSObject

/**
 单例
 */
+ (instancetype)shareLocalNotificationTool;

/**
 请求授权,一般在didFinishLaunchingWithOptions:调用
 */
- (void)registerLocalNotification;

#pragma mark - 发送本地通知
/**
 创建本地通知，在多少秒后触发
 
 @param title 主标题
 @param subTitle 副标题
 @param badge 增加的application通知数
 @param body 主要信息
 @param interval interval后触发
 @param repeats 是否重复触发
 @param identifier 标识
 */
- (void)localNotificationWithTitle:(NSString *)title
                         subTtitle:(NSString *)subTitle
                             badge:(NSInteger)badge
                              body:(NSString *)body
               timeIntervalTrigger:(NSTimeInterval)interval
                           repeats:(BOOL)repeats
                        identifier:(NSString *)identifier;

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
                        identifier:(NSString *)identifier;

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
                        identifier:(NSString *)identifier;

/**
 创建本地通知
 
 @param content 本地通知
 @param trigger 触发时间
 @param identifier 标识
 */
- (void)localNotificationWithContent:(UNNotificationContent *)content
                             trigger:(UNNotificationTrigger *)trigger
                          identifier:(NSString *)identifier;

@end
