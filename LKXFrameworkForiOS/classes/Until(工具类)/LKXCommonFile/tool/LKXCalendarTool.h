//
//  LKXCalendarTool.h
//  Polyu
//
//  Created by lkx on 2017/3/16.
//  Copyright © 2017年 西格美.刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface LKXCalendarTool : NSObject

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
- (EKEvent *)createEvent;

/**
 添加事件
 
 @param event 事件对象
 @param success 是否写入成功
 */
- (void)writeDataWithEvent:(EKEvent *)event success:(void(^)(BOOL success))success;

/**
 查询事件
 
 @param startDate 开始时间
 @param endDate 结束时间
 @param types 事件类型组,必须是EKEntityType类型
 @return 事件数组
 */
- (NSArray *)readEventsWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate entityTypes:(NSArray *)types;

/**
 时间加减
 
 @param ti 正数增加,负数减少
 @return 计算后的时间
 */
- (instancetype)lkx_dateByAddingTimeInterval:(NSTimeInterval)ti;

/**
 按分钟时间加减
 
 @param minute 正数增加,负数减少
 @return 计算后的时间
 */
- (instancetype)lkx_dateByAddingMinute:(NSInteger)minute;

/**
 按小时时间加减
 
 @param hour 正数增加,负数减少
 @return 计算后的时间
 */
- (instancetype)lkx_dateByAddingHour:(NSInteger)hour;

/**
 按天时间加减
 
 @param day 正数增加,负数减少
 @return 计算后的时间
 */
- (instancetype)lkx_dateByAddingDay:(NSInteger)day;

@end
