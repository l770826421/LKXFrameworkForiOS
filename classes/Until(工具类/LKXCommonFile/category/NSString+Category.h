//
//  NSString+Category.h
//  MyCategory
//
//  Created by lkx on 14-11-24.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

#pragma mark - 类方法
/*
 * 获取手机的UUID
 */
+ (NSString *)uuid;

/*
 * 转换为百万/十亿(million/billion)级数据
 * @parameter number 为long long
 * @return NSString  @"x.x million" @"x.x billion"
 */
+ (NSString *)convertBigDataWithLongLong:(long long)number;

/**
 *  将时间戳转换X year X month X days X hour X minute
 *
 *  @param timeInterval 时间戳
 *
 *  @return X year X month X days X hour X minute的字符串
 */
+ (NSString *)remainTimeString:(long long )timeInterval;

/**
 *  将GB2312字符转为UTF-8
 *
 *  @param data GB2312字符Data
 *
 *  @return UTF-8字符串
 */
+ (NSString *)GB2312ToUTF8:(NSData *)data;

#pragma mark - 实例方法
/**
 *  将字符串中得某些字符或字符串设置不同字体颜色
 *
 *  @param color      第一个字符设置为颜色
 *  @param atherColor 其他字符颜色
 *
 *  @return 返回类型为NSAttributedString
 */
- (NSAttributedString *)attributedFirstChar:(UIColor *)color
                                 atherColor:(UIColor *)atherColor;

/**
 *  获取NSAttributedString
 *
 *  @param text1  文本1
 *  @param color1 文本1的颜色
 *  @param text2  文本2
 *  @param color2 文本2的颜色
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)attributedText1:(NSString *)text1
                                 color1:(UIColor *)color1
                                  text2:(NSString *)text2
                                 color2:(UIColor *)color2;

/*
 * 获取attributedString的属性字典
 *
 * @return 返回类型为NSDictionary
 */
- (NSDictionary *)attributedDictionary;

/*
 * 去除字符串最后的字符串
 * @parameter suffixStr 去除的字符串
 */
- (NSString *)subSuffixString:(NSString *)suffixStr;

/**
 *  将手机号中间四位置为*
 * 例如: 15845689541 -> 158****9541
 *
 *  @return NSString
 */
- (NSString *)phoneMiddleFourWithStar;

/*
 * 获取指定URL的MIMEType类型
 */
- (NSString *)mimeType;

/**
 *  除去字符串中的第一个匹配的子字符串
 *
 *  @param str 要删除的子字符串
 *
 *  @return NSString
 */
- (NSString *)cutWithString:(NSString *)str;

/**
 *  返回首字母并且大写
 *
 *  @return 一个字母的字符串
 */
- (NSString *)uppercaseWithFirstChar;

/**
 *  根据文字多少,格式大小绘制所需显示区域
 *
 *  @param textSize 文字显示区域
 *  @param fontSize 文字大小
 *
 *  @return 实际显示区域
 */
- (CGSize)getSizeWithTextSize:(CGSize)textSize
                         fontSize:(CGFloat)fontSize;

@end
