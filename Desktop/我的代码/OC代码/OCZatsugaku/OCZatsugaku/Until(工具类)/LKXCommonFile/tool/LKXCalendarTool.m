//
//  LKXCalendarTool.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/3/16.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXCalendarTool.h"
#import <EventKit/EventKit.h>
#import "NSDate+Formatter.h"
#import "NSDate+Category.h"

@interface LKXCalendarTool ()

/** 事件市场 */
@property (nonatomic, strong) EKEventStore *eventStore;

@end

@implementation LKXCalendarTool

/**
 检查日历或备忘录权限
 
 @param entityType 日历或者备忘录枚举值
 @return 权限
 */
+ (EKAuthorizationStatus)testEntityPowerWithEntityType:(EKEntityType)entityType {
    EKAuthorizationStatus ekStatus = [EKEventStore authorizationStatusForEntityType:entityType];
    return ekStatus;
}

/**
 获取日历或者备忘录权限
 
 @param entityType 日历或者备忘录枚举值
 @param completion 获取结果
 */
+ (void)requireEntityPowerWithEntityType:(EKEntityType)entityType completion:(void(^)(BOOL granted, NSError * _Nullable error))completion {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:entityType completion:^(BOOL granted, NSError * _Nullable error) {
        if (completion) {
            completion(granted, error);
        }
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return self;
}

/**
 创建事件,必须使用这里使用的事件,这里设置基本的配置

 *  标题 title;
 *  活动标识 eventIdentifier;
 *  指示这个活动是否是全天活动 allDay;
 *  开始时间 startDate,默认创建开始;
 *  结束时间 endDate,默认一天;
 *  全天提示 allDay,默认YES;
 
 // 添加提醒
 [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f *  60.0f * 24]];
 @return 事件对象
 */
- (EKEvent *)createEvent {
    EKEvent *event = [EKEvent eventWithEventStore:_eventStore];
    
    event.startDate = [NSDate date];
    event.endDate = [event.startDate lkx_dateByAddingDay:1];
    event.allDay = YES;
    
    return event;
}

/**
 添加事件

 @param event 事件对象
 @param success 是否写入成功
 */
- (void)writeDataWithEvent:(EKEvent *)event success:(void(^)(BOOL success))success {
    [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            [kMBHUDTool showHUDWithText:@"事件市场获取失败" delay:kMBHUDDelay];
            return;
        }
        
        if (!granted) {
            [kMBHUDTool showHUDWithText:@"您已拒绝访问日历,请前往设置开启" delay:kMBHUDDelay];
            return;
        }
        
        // 事件保存到日历
        // 创建事件
        // refresh 返回YES标识活动可用,否者标识被删除或者无效。
        
        [event setCalendar:[_eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [_eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        if (err) {
            LKXMLog(@"保存失败%@", err);
            success(NO);
        } else {
            success(YES);
        }
    }];
}

/**
 查询事件

 @param startDate 开始时间
 @param endDate 结束时间
 @param types 事件类型组,必须是EKEntityType EKCalendarType类型
 @return 事件数组
 */
- (NSArray *)readEventsWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate entityTypes:(NSArray *)types {
    NSMutableArray *calendars = [NSMutableArray array];
    for (NSNumber *type in types) {
        EKEntityType entityType = type.unsignedIntegerValue;
        EKCalendar *calendar = [EKCalendar calendarForEntityType:entityType eventStore:_eventStore];
        [calendars addObject:calendar];
    }
    NSPredicate *predicate = [_eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:calendars];
    NSArray *events = [_eventStore eventsMatchingPredicate:predicate];
    
    for (EKEvent *event in events) {
        LKXMLog(@"日历事件:%@ --- ", event.title);
    }
    
    return events;
}

- (void)removeEvent {
    
}

@end














