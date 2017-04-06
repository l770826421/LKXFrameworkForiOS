//
//  NSDate+Category.m
//  MyCategory
//
//  Created by lkx on 14-11-19.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

#pragma mark - 类方法
/*
 * 将时间戳转化为HH:mm:ss格式
 * 一般用于算倒计时，或者当前时间，不计算超过天以外的时间
 * @parameter timeInterval 时间戳
 * return HH:mm:ss 格式的时间
 */
+ (NSString *)stringWithTimeInterval:(NSInteger)timeInterval
{
    NSString *timeStr;
    int hour = (int) (timeInterval / (60*60));
    int minute = timeInterval / 60 % 60;
    int second = timeInterval % 60;
    timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    return timeStr;
}

/**
 *  将时间戳换算成一个时间，将小时、分钟、秒数的数组
 *
 *  @param timeInterval 秒数,单位是秒
 *
 *  @return 时间，将小时、分钟、秒数的数组
 */
+ (NSArray *)timeArrayWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSString *hourStr;
    NSString *minuteStr;
    NSString *secondStr;
    int timeTl = (int)timeInterval % (24 * 60 * 60);
    int hour = timeTl / (60 * 60);
    int minute = timeTl / 60 % 60;
    int second = timeTl % 60;
    hourStr = [NSString stringWithFormat:@"%02d", hour];
    minuteStr = [NSString stringWithFormat:@"%02d", minute];
    secondStr = [NSString stringWithFormat:@"%02d", second];
    return @[hourStr, minuteStr, secondStr];
}

/*
 * 将字符串转化NSDate
 * 例如: 1991-09-08 转为时间
 */
+ (NSDate *)dateWithString:(NSString *)dateString
                 formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

#pragma mark - 实例方法
/**
 *  将时间转为指定的格式
 *
 *  @param formatter 格式的字符串
 *
 *  @return 指定格式的时间
 */
- (NSString *)stringWithFormatter:(NSString *)formatter
{
    NSString *dateStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

/**
 *  将时间时区转为系统时间
 *
 *  @return 系统时间
 */
- (NSDate *)dateWithSystem
{
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate *date = [self dateByAddingTimeInterval:timeZoneOffset];
    return date;
}

/**
 *  计算传入的时间与当前的时间差
 *
 *  @return 时间差
 */
- (NSTimeInterval)subTimeWithSystem
{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeIntl = [self timeIntervalSinceDate:nowDate];
    return timeIntl;
}

/**
 *  将时间转为当前时区的时间
 *
 *  @return 当前时区的时间
 */
- (NSDate *)getNowDate
{
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"]; //UTC
    NSTimeZone *destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceGMToffset = [sourceTimeZone secondsFromGMTForDate:self];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    NSTimeInterval interval = destinationGMTOffset - sourceGMToffset;
    NSDate *destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}

/**
 *  计算两个时间差 self为开始时间
 *
 *  @param endDate 结束时间
 *
 *  @return 时间差
 */
- (NSTimeInterval)deltaTimeWithEndDate:(NSDate *)endDate
{
    if (self == nil || endDate == nil)
    {
        return 0;
    }
    
    NSTimeInterval startTIl = [self timeIntervalSince1970];
    NSTimeInterval endTIl = [endDate timeIntervalSince1970];
    NSTimeInterval subTimeTIl = endTIl - startTIl;
    if (subTimeTIl < 0)
    {
        subTimeTIl = -subTimeTIl;
    }
    
    return subTimeTIl;
}

/**
 *  将日期格式化为 2011年4月4日 星期一
 *
 *  @return 2011年4月4日 星期一 格式的时间字符串
 */
- (NSString *)weekFormatterDate_ZH
{
    NSString *tempStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // zh_CN 中文日期的标识符
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    dateFormatter.dateFormat = @"yyyy '-' MM '-' dd ' ' EEEE";
    tempStr = [dateFormatter stringFromDate:self];
    return tempStr;
}

/**
 *  将日期格式化为 2011年4月4日
 *
 *  @return 2011年4月4日 格式的时间字符串
 */
- (NSString *)dayFormatterDate_ZH
{
    NSString *tempStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // zh_CN 中文日期的标识符
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    dateFormatter.dateFormat = @"yyyy '-' MM '-' dd";
    tempStr = [dateFormatter stringFromDate:self];
    return tempStr;
}

/**
 *  获取日期的具体信息
 *  本方法是为了获取星期
 *  注意: 返回星期是int数据类型,和中国传统星期是有差异的
 *
 *  @return 日期的基本信息
 */
- (NSDateComponents *)dateInfo
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    // NSGregorianCalendar
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond; // NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    components = [calendar components:unitFlags fromDate:self];
    /*
      *  NSInteger week = [components weekday];
      *  NSInteger month = [comps month];
      *	 NSInteger day = [comps day];
      *	 NSInteger hour = [comps hour];
      *	 NSInteger min = [comps minute];
      *	 NSInteger sec = [comps second];
     */
    return components;
}

/**
 时间加减
 
 @param ti 正数增加,负数减少
 @return 计算后的时间
 */
- (instancetype)lkx_dateByAddingTimeInterval:(NSTimeInterval)ti {
    NSDate *date = nil;
    
#if __IPHONE_OS_VERSION_MAX_REQUIRED < __IPHONE_10_0
    date = [self dateByAddingTimeInterval:ti];
#else
    date = [self dateByAddingTimeInterval:ti];
#endif
    
    return date;
}

/**
 按分钟时间加减
 
 @param minute 正数增加,负数减少
 @return 计算后的时间
 
 */
- (instancetype)lkx_dateByAddingMinute:(NSInteger)minute {
    NSTimeInterval ti = 60 * minute;
    return [self lkx_dateByAddingTimeInterval:ti];
}

/**
 按小时时间加减
 
 @param hour 正数增加,负数减少
 @return 计算后的时间
 */
- (instancetype)lkx_dateByAddingHour:(NSInteger)hour {
    NSTimeInterval ti = 60 * 60 * hour;
    return [self lkx_dateByAddingTimeInterval:ti];
}

/**
 按天时间加减
 
 @param day 正数增加,负数减少
 @return 计算后的时间
 */
- (instancetype)lkx_dateByAddingDay:(NSInteger)day {
    NSTimeInterval ti = 60 * 60 * 24 * day;
    return [self lkx_dateByAddingTimeInterval:ti];
}

@end
