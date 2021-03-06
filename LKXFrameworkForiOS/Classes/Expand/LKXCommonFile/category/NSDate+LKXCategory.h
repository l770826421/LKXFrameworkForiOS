//
//  NSDate+LKXCategory.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 14-11-19.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LKXCategory)

#pragma mark - 类方法
/*
 * 将时间戳转化为HH:mm:ss格式
 * 一般用于算倒计时，或者当前时间，不计算超过天以外的时间
 * @parameter timeInterval 时间戳
 * return HH:mm:ss 格式的时间
 */
+ (NSString *)lkx_stringWithTimeInterval:(NSInteger)timeInterval;

/**
 *  将时间戳换算成一个时间，将小时、分钟、秒数的数组
 *
 *  @param timeInterval 秒数,单位是秒
 *
 *  @return 时间，将小时、分钟、秒数的数组
 */
+ (NSArray *)lkx_timeArrayWithTimeInterval:(NSTimeInterval)timeInterval;

#pragma mark - 实例方法
/**
*  将时间转为指定的格式
*
*  @param formatter 格式的字符串
*
*  @return 指定格式的时间
*/
- (NSString *)lkx_stringWithFormatter:(NSString *)formatter;

/**
 *  将时间时区转为系统时间
 *
 *  @return 系统时间
 */
- (NSDate *)lkx_dateWithSystem;

/**
 *  计算传入的时间与当前的时间差
 *
 *  @return 时间差
 */
- (NSTimeInterval)lkx_subTimeWithSystem;

/**
 *  将时间转为当前时区的时间
 *
 *  @return 当前时区的时间
 */
- (NSDate *)lkx_getNowDate;

/**
 *  计算两个时间差 self为开始时间
 *
 *  @param endDate 结束时间
 *
 *  @return 时间差
 */
- (NSTimeInterval)lkx_deltaTimeWithEndDate:(NSDate *)endDate;

/**
 *  将日期格式化为 2011年4月4日 星期一
 *
 *  @return 2011年4月4日 星期一 格式的时间字符串
 */
- (NSString *)lkx_weekFormatterDate_ZH;

/**
 *  将日期格式化为 2011年4月4日
 *
 *  @return 2011年4月4日 格式的时间字符串
 */
- (NSString *)lkx_dayFormatterDate_ZH;

/**
 *  获取日期的具体信息
 *  本方法是为了获取星期
 *  注意: 返回星期是int数据类型,和中国传统星期是有差异的
 *
 *  @return 日期的基本信息
 */
- (NSDateComponents *)lkx_dateInfo;

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
