//
//  NSDate+Formatter.m
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "NSDate+Formatter.h"

#define kSecondForYear (365 * kSecondForDay)
#define kSecondForWeek (7 * kSecondForDay)
#define kSecondForMonth (30 * kSecondForDay)
#define kSecondForDay (24 * kSecondForHour)
#define kSecondForHour (60 * kSecondForMinute)
#define kSecondForMinute 60

@implementation NSDate (Formatter)
/**
 *  @author 刘克邪
 *
 *  @brief  将时间字符串转为时间
 *
 *  @param dateString 时间字符串
 *  @param formatter  时间格式
 *
 */
+ (NSDate *)dateWithString:(NSString *)dateString formatter:(NSString *)formatter {
    
    NSDate *date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    date = [dateFormatter dateFromString:dateString];
    
    return date;
}

/**
 *  @author 刘克邪
 *
 *  @brief  将时间转为当前时区的时间
 *
 */
- (NSDate *)dateForCurrentTimeZone {
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate *date = [self dateByAddingTimeInterval:timeZoneOffset];
    return date;
}

/**
 *  @author 刘克邪
 *
 *  @brief  将时间格式转为formatter
 *
 *  @param formatter 时间格式
 *
 */
- (NSString *)dateWithFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    // 统一设置成东八区,为了服务器端的超时判断
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT+0800"];
    LKXMLog(@"timeZone = %@", dateFormatter.timeZone);
    
    NSString *str = [dateFormatter stringFromDate:self];
    return str;
}

/**
 *  @author 刘克邪
 *
 *  @brief  与当前时间的时间间隔
 *
 */
- (NSTimeInterval)dateIntervalWithNow {
    
    NSDate *currentDate = [NSDate date];
    
    return [self dateIntervalWithOhterDate:currentDate];
}

/**
 *  @author 刘克邪
 *
 *  @brief  与一时间的时间间隔
 *
 */
- (NSTimeInterval)dateIntervalWithOhterDate:(NSDate *)otherDate {
    
    NSDate *currentDate = [otherDate dateForCurrentTimeZone];
    NSTimeInterval currentInterval = [currentDate timeIntervalSince1970];
    
    NSTimeInterval interval = [self timeIntervalSince1970];
    
    NSTimeInterval dateInterval = currentInterval - interval;
    
    return dateInterval;
}

/**
 *  @author 刘克邪
 *
 *  @brief  与当前时间的时间间隔的字符串
 *
 */
- (NSString *)dateIntervalStringWithNow {
    
    return [self dateIntervalStringWithOhterDate:[NSDate date]];
}

/**
 *  @author 刘克邪
 *
 *  @brief  与一时间的时间间隔的字符串
 *
 */
- (NSString *)dateIntervalStringWithOhterDate:(NSDate *)otherDate {
    
    NSTimeInterval dateInterval = [self dateIntervalWithOhterDate:otherDate];
    
    NSString *src;
    
    if (dateInterval >= kSecondForYear) {
        src = [NSString stringWithFormat:@"%lld年", (long long)dateInterval / kSecondForYear];
    } else if (dateInterval >= kSecondForMonth) {
        src = [NSString stringWithFormat:@"%lld月", (long long)dateInterval / kSecondForMonth];
    } else {
        src = @"一个月以内";
    }
    /*
    else if (dateInterval >= kSecondForDay) {
        src = [NSString stringWithFormat:@"%lld天", (long long)dateInterval / kSecondForDay];
    } else if (dateInterval >= kSecondForHour) {
        src = [NSString stringWithFormat:@"%lld时", (long long)dateInterval / kSecondForHour];
    } else if (dateInterval >= kSecondForMinute) {
        src = [NSString stringWithFormat:@"%lld分", (long long)dateInterval / kSecondForMinute];
    } else if (dateInterval >= kSecondForHour) {
        src = [NSString stringWithFormat:@"%lld秒", (long long)dateInterval];
    }
     */
    
    return src;
}

@end
