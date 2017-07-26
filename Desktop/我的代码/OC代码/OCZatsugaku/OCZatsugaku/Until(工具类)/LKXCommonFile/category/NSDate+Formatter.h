//
//  NSDate+Formatter.h
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

// YYYYMMDDHHmmss
static NSString * const Date_Formatter_YYYYMMddHHmmss = @"YYYYMMddHHmmss";

// YYYY-MM-DD HH:mm:ss
static NSString * const Date_Formatter_Lunk_YYYYMMddHHmmss = @"YYYY-MM-dd HH:mm:ss";

// YYYY/MM/DD HH:mm:ss
static NSString * const Date_Formatter_Bias_YYYYMMddHHmmss = @"YYYY/MM/dd HH:mm:ss";

// dd-MM-YYYY HH:mm:ss
static NSString * const Date_Formatter_Lunk_ddMMYYYYHHmmss = @"dd-MM-YYYY HH:mm:ss";

// YYYY/MM/DD HH:mm:ss
static NSString * const Date_Formatter_Bias_ddMMYYYYHHmmss = @"dd/MM/YYYY HH:mm:ss";

// YYYY-MM-DD HH:mm
static NSString * const Date_Formatter_Lunk_YYYYMMddHHmm = @"YYYY-MM-dd HH:mm";

// YYYY/MM/DD HH:mm
static NSString * const Date_Formatter_Bias_YYYYMMddHHmm = @"YYYY/MM/dd HH:mm";

// dd-MM-YYYY HH:mm
static NSString * const Date_Formatter_Lunk_ddMMYYYYHHmm = @"dd-MM-YYYY HH:mm";

// YYYY/MM/DD HH:mm
static NSString * const Date_Formatter_Bias_ddMMYYYYHHmm = @"dd/MM/YYYY HH:mm";

// YYYY-MM-DD
static NSString * const Date_Formatter_Lunk_YYYYMMdd = @"YYYY-MM-dd";

// YYYY/MM/DD
static NSString * const Date_Formatter_Bias_YYYYMMdd = @"YYYY/MM/dd";

// dd-MM-YYYY
static NSString * const Date_Formatter_Lunk_ddMMYYYY = @"dd-MM-YYYY";

// YYYY/MM/DD
static NSString * const Date_Formatter_Bias_ddMMYYYY = @"dd/MM/YYYY";

// YYYY/MM/DD
static NSString * const Date_Formatter_Dot_YYYYMMdd = @"YYYY.MM.dd";

// 北京时区
static NSString * const BeijingTimezon = @"Asia/BeiJing";

/**
 *  @author 刘克邪
 *
 *  @brief  时间格式扩展
 */
@interface NSDate (Formatter)

/**
 *  @author 刘克邪
 *
 *  @brief  将时间字符串转为时间
 *
 *  @param dateString 时间字符串
 *  @param formatter  时间格式
 *
 */
+ (NSDate *)dateWithString:(NSString *)dateString formatter:(NSString *)formatter;

/**
 *  @author 刘克邪
 *
 *  @brief  将时间转为当前时区的时间
 *
 */
- (NSDate *)dateForCurrentTimeZone;

/**
 *  @author 刘克邪
 *
 *  @brief  将时间格式转为formatter
 *
 *  @param formatter 时间格式
 *
 */
- (NSString *)dateWithFormatter:(NSString *)formatter;

/**
 *  @author 刘克邪
 *
 *  @brief  与当前时间的时间间隔
 *
 */
- (NSTimeInterval)dateIntervalWithNow;

/**
 *  @author 刘克邪
 *
 *  @brief  与一时间的时间间隔
 *
 */
- (NSTimeInterval)dateIntervalWithOhterDate:(NSDate *)otherDate;

/**
 *  @author 刘克邪
 *
 *  @brief  与当前时间的时间间隔的字符串
 *
 */
- (NSString *)dateIntervalStringWithNow;

/**
 *  @author 刘克邪
 *
 *  @brief  与一时间的时间间隔的字符串
 *
 */
- (NSString *)dateIntervalStringWithOhterDate:(NSDate *)otherDate;

@end
