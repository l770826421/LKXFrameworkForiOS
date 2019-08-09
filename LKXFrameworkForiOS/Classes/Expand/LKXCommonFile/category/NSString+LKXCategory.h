//
//  NSString+LKXCategory.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 14-11-24.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LKXCategory)

#pragma mark - 类方法
/*
 * 获取手机的UUID
 */
+ (NSString *)lkx_uuid;

/*
 * 转换为百万/十亿(million/billion)级数据
 * @parameter number 为long long
 * @return NSString  @"x.x million" @"x.x billion"
 */
+ (NSString *)lkx_convertBigDataWithLongLong:(long long)number;

/**
 *  将时间戳转换X year X month X days X hour X minute
 *
 *  @param timeInterval 时间戳
 *
 *  @return X year X month X days X hour X minute的字符串
 */
+ (NSString *)lkx_remainTimeString:(long long )timeInterval;

/**
 *  将GB2312字符转为UTF-8
 *
 *  @param data GB2312字符Data
 *
 *  @return UTF-8字符串
 */
+ (NSString *)lkx_GB2312ToUTF8:(NSData *)data;

/**
 *  根据地址获取文件夹或文件大小
 *
 *  @param path 文件夹或文件路径
 *
 *  @return 返回文件大小
 */
+ (long long)lkx_folderOrFileSizeAtPath:(NSString *)path;

/**
 *  @author 刘克邪
 *
 *  @brief  当字符串为nil或者长度为0是返回YES,否则返回NO
 *
 */
+ (BOOL)lkx_isNullWithString:(NSString *)src;

/**
 *  @author 刘克邪
 *
 *  @brief  当字符串为nil、空字符串、长度为0,返回YES,否则返回NO
 *
 */
+ (BOOL)lkx_isEmptyWithString:(NSString *)src;

#pragma mark - 实例方法

/*
 * 获取attributedString的属性字典
 *
 * @return 返回类型为NSDictionary
 */
- (NSDictionary *)lkx_attributedDictionary;

/*
 * 去除字符串最后的字符串
 * @parameter suffixStr 去除的字符串
 */
- (NSString *)lkx_subSuffixString:(NSString *)suffixStr;

/**
 *  将手机号中间四位置为*
 * `例如: 15845689541 -> 158****9541
 *
 *  @return NSString
 */
- (NSString *)lkx_phoneMiddleFourWithStar;

/**
 *  将姓名中间的位置为*
 *  例如: 张三->*三,李世民->李*民
 *
 *  @return NSString
 */
- (NSString *)lkx_nameMiddleWithStar;

/**
 *  将身份证号码中间的位置为*
 *  例如: 362426188908099803 ->  3*************9803
 *
 *  @return NSString
 */
- (NSString *)lkx_IDCardNumberMiddleWithStar;

/*
 * 获取指定URL的MIMEType类型
 */
- (void)lkx_mimeType:(void (^)(NSString *mimeType))mimeTypeBlock;

/**
 *  除去字符串中的第一个匹配的子字符串
 *
 *  @param str 要删除的子字符串
 *
 *  @return NSString
 */
- (NSString *)lkx_cutWithString:(NSString *)str;

/**
 *  返回首字母并且大写
 *
 *  @return 一个字母的字符串
 */
- (NSString *)lkx_uppercaseWithFirstChar;

/**
 *  根据文字多少,格式大小绘制所需显示区域
 *
 *  @param textSize 文字显示区域
 *  @param fontSize 文字大小
 *
 *  @return 实际显示区域
 */
- (CGSize)lkx_getSizeWithTextSize:(CGSize)textSize
                     fontSize:(CGFloat)fontSize;

/**
 *  @author 刘克邪
 *
 *  @brief  将字符串转为UTF8编码
 *
 *  @return utf-8编码字符串
 */
- (NSString *)lkx_UTF8;

/**
 转base64字符串

 @return base64字符串
 */
- (NSString *)lkx_toBase64String;

/**
 base64字符串转明文

 @return 返回正常的字符串
 */
- (NSString *)lkx_base64StringToString;

/**
 *  @author 刘克邪
 *
 *  @brief  将字符串转成NSDictionary
 *
 */
- (NSMutableDictionary *)lkx_dictionaryWithString;

@end
