//
//  LKXCalendarTool.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/3/16.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface LKXCalendarTool : NSObject

/**
 检查日历或备忘录权限
 
 @param entityType 日历或者备忘录枚举值
 @return 权限
 */
+ (EKAuthorizationStatus)testEntityPowerWithEntityType:(EKEntityType)entityType;

/**
 获取日历或者备忘录权限
 
 @param entityType 日历或者备忘录枚举值
 @param completion 获取结果
 */
+ (void)requireEntityPowerWithEntityType:(EKEntityType)entityType completion:(void(^_Nullable)(BOOL granted, NSError * _Nullable error))completion;

/**
 创建事件,必须使用这里使用的事件,这里设置基本的配置
 
 *  标题 title;
 *  活动标识 eventIdentifier;
 *  指示这个活动是否是全天活动 allDay;
 *  开始时间 startDate,默认创建开始;
 *  结束时间 endDate,默认一天;
 *  全天提示 allDay,默认YES;
 
 // 添加提醒 开始之前一天提醒
 [event addAlarm:[EKAlarm alarmWithRelativeOffset:-60.0f *  60.0f * 24]];
 @return 事件对象
 */
- (EKEvent * _Nonnull)createEvent;

/**
 添加事件
 
 @param event 事件对象
 @param success 是否写入成功
 */
- (void)writeDataWithEvent:(EKEvent * _Nonnull)event success:(void(^ _Nonnull)(BOOL success))success;

/**
 查询事件
 
 @param startDate 开始时间
 @param endDate 结束时间
 @param types 事件类型组,必须是EKEntityType类型
 @return 事件数组
 */
- (NSArray * _Nonnull)readEventsWithStartDate:(NSDate * _Nonnull)startDate endDate:(NSDate * _Nonnull)endDate entityTypes:(NSArray * _Nonnull)types;

@end
