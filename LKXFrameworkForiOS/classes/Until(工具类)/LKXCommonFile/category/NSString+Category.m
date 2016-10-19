//
//  NSString+Category.m
//  MyCategory
//
//  Created by lkx on 14-11-24.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "NSString+Category.h"

#define Billion 1000000000.0    // 十亿
#define Million 1000000.0       // 百万

@implementation NSString (Category)

#pragma mark - 类方法
/*
 * 获取手机的UUID
 */
+ (NSString *)uuid
{
//    CFUUIDRef puuid = CFUUIDCreate(nil);
//    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
//    NSString *uuid = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    NSUUID *uuid = [[UIDevice currentDevice] identifierForVendor];
    NSString *uuidStr = [NSString stringWithFormat:@"%@", uuid];
    NSArray *uuidArr = [uuidStr componentsSeparatedByString:@" "];
    return [uuidArr lastObject];
}

/*
 * 转换为百万/十亿(million/billion)级数据
 * @parameter number 为long long
 * @return NSString  @"x.x million" @"x.x billion"
 */
+ (NSString *)convertBigDataWithLongLong:(long long)number
{
    if (number > 1000000000)
    {
        return [NSString stringWithFormat:@" %.1f billion", number/Billion];
    }
    else
    {
        return [NSString stringWithFormat:@" %.1f million", number/Million];
    }
}


/**
 *  将时间戳转换X year X month X days X hour X minute
 *
 *  @param timeInterval 时间戳
 *
 *  @return X year X month X days X hour X minute的字符串
 */
+ (NSString *)remainTimeString:(long long )timeInterval
{
    NSMutableString *string = [NSMutableString string];
    NSInteger year = (NSInteger) (timeInterval / (365 * 30 * 24 * 60 * 60));
    if (year > 0)
    {
        [string appendFormat:@"%ldyear", (long)year];   //year
    }
    if (year > 0)
    {
        return string;
    }
    
    int month = timeInterval % (365 * 30 * 24 * 60 * 60) / (30 * 24 * 60 * 60);
    if (month > 0)
    {
        [string appendFormat:@"%dmonth", month];  //month
    }
    if (month > 0)
    {
        return string;
    }
    
    int day = timeInterval % (30 * 24 * 60 * 60) / (24 * 60 * 60);
    if (day > 0)
    {
        [string appendFormat:@"%ddays", day];    //days
    }
    if (day > 0)
    {
        return string;
    }
    
    int hour = timeInterval % (24 * 60 * 60) / (60 * 60);
    if (hour > 0)
    {
        [string appendFormat: @"%dhours", hour];  //hours
    }
    if (hour > 0)
    {
        return string;
    }
    
    int minute = timeInterval % (60 * 60) / 60;
    if (minute > 0)
    {
        [string appendFormat:@"%dminute", minute];  //minute
    }
    return string;
}

/**
 *  将GB2312字符转为UTF-8
 *
 *  @param data GB2312字符Data
 *
 *  @return UTF-8字符串
 */
+ (NSString *)GB2312ToUTF8:(NSData *)data
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_2312_80);
    NSString *rstString = [[NSString alloc] initWithData:data encoding:encoding];
    return rstString;
}

- (NSString *)encodingURLString
{
    // [NSString stringByAddingPercentEncodingWithAllowedCharacters:]
    NSString *encodingString =  [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"]];//(__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    if (encodingString.length > 0)
    {
        return encodingString;
    }
    return @"";
}

/**
 *  根据地址获取文件夹或文件大小
 *
 *  @param path 文件夹或文件路径
 *
 *  @return 返回文件大小
 */
+ (long long)folderOrFileSizeAtPath:(NSString *)path
{
    NSError *error;
    long long folderSize = 0;
    if ([kFileManager fileExistsAtPath:path])
    {
        folderSize += [[kFileManager attributesOfItemAtPath:path error:&error] fileSize];
        LKXMLog(@"文件大小获取错误 == %@", error);
    }
    else
    {
        NSEnumerator *childFolerOrFileEnumerator = [[kFileManager subpathsAtPath:path] objectEnumerator];
        for (NSString *fileName in childFolerOrFileEnumerator)
        {
            NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            if ([kFileManager fileExistsAtPath:fileAbsolutePath])
            {
                folderSize += [[kFileManager attributesOfItemAtPath:path error:&error] fileSize];
                LKXMLog(@"文件大小获取错误 == %@", error);
            }
        }
    }
    return folderSize;
}

/**
 *  @author 刘克邪
 *
 *  @brief  当字符串为nil或者长度为0是返回YES,否则返回NO
 *
 */
+ (BOOL)isNullWithString:(NSString *)src {
    if (src == nil && src.length == 0) {
        return YES;
    }
    return NO;
}

/**
 *  @author 刘克邪
 *
 *  @brief  当字符串为nil、空字符串、长度为0,返回YES,否则返回NO
 *
 */
+ (BOOL)isEmptyWithString:(NSString *)src {
    BOOL isEmpty = [NSString isNullWithString:src];
    if (!isEmpty) {
        if ([src stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return isEmpty;
}

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
                                 atherColor:(UIColor *)atherColor
{
    if (self.length == 0 || self == nil)
    {
        return nil;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range0 = NSMakeRange(0, 1);
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range0];
    NSRange range1 = NSMakeRange(1, self.length - 1);
    [attributedString addAttribute:NSForegroundColorAttributeName value:atherColor range:range1];
    return attributedString;
}

/**
 *  获取NSAttributedString
 *
 *  @param text  文本
 *  @param color 文本的颜色
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)attributedText:(NSString *)text
                                 color:(UIColor *)color
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = [self rangeOfString:text];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return attributedStr;
}

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
                                 color2:(UIColor *)color2
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = [self rangeOfString:text1];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color1 range:range];
    
    range = [self rangeOfString:text2];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color2 range:range];
    
    return attributedStr;
}

/*
 * 获取attributedString的属性字典
 *
 * @return 返回类型为NSDictionary
 */
- (NSDictionary *)attributedDictionary
{
    NSAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = NSMakeRange(0, attributedStr.length);
    NSDictionary *dic = [attributedStr attributesAtIndex:0 effectiveRange:&range];
    return dic;
}

/*
 * 去除字符串最后的字符串
 * @parameter suffixStr 去除的字符串
 */
- (NSString *)subSuffixString:(NSString *)suffixStr
{
    NSString *src;
    if ([self hasSuffix:suffixStr])
    {
        src = [self substringToIndex:(self.length - suffixStr.length)];
    }
    return src;
}

/**
 *  将手机号中间四位置为*
 *  例如: 15845689541 -> 158****9541
 *
 *  @return NSString
 */
- (NSString *)phoneMiddleFourWithStar
{
    NSMutableString *src = [NSMutableString stringWithString:self];
    if (src.length >= 8) {
        [src replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//        str = [src stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return [src copy];
}

/**
 *  将姓名中间的位置为*
 *  例如: 张三->*三,李世民->李*民
 *
 *  @return NSString
 */
- (NSString *)nameMiddleWithStar
{
    NSMutableString *src = [NSMutableString stringWithString:self];
    
    NSRange range = NSMakeRange(1, 1);
    if (src.length == 2) {
        [src replaceCharactersInRange:range withString:@"*"];
//        str = [src stringByReplacingCharactersInRange:range withString:@"*"];
    } else if (src.length > 2) {
        NSInteger length = self.length - 2;
        range = NSMakeRange(1, length);
        [src replaceCharactersInRange:range withString:@"**"];
//        str = [src stringByReplacingCharactersInRange:range withString:@"**"];
    }
    return [src copy];;
}

/**
 *  将身份证号码中间的位置为*
 *  例如: 362426188908099803 ->  3*************9803
 *
 *  @return NSString
 */
- (NSString *)IDCardNumberMiddleWithStar
{
    NSMutableString *src = [NSMutableString stringWithString:self];
    
    NSRange range = NSMakeRange(1, 13);
    if (src.length == 18) {
        [src replaceCharactersInRange:range withString:@"*************"];
//        str = [src stringByReplacingCharactersInRange:range withString:@"*************"];
    }
    return [src copy];;
}

/*
 * 获取指定URL的MIMEType类型
 */
- (void)mimeType:(void (^)(NSString *mimeType))mimeTypeBlock {
    if (Dev_IOSVersion < 9.0) {
        mimeTypeBlock([self mimeTypeBefore_iOS_9_0]);
    } else {
        [self mimeTypeAfter_iOS_9_0:^(NSString *mimeType) {
            mimeTypeBlock(mimeType);
        }];
    }
}


/*
 * iOS9.0前获取指定URL的MIMEType类型
 */
- (NSString *)mimeTypeBefore_iOS_9_0
{
    NSURL *url = [NSURL URLWithString:self];
    //1NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2NSURLConnection
    
    //3 在NSURLResponse里，服务器告诉浏览器用什么方式打开文件。
    
    //使用同步方法后去MIMEType
    NSURLResponse *response = nil;
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSLog(@"---%@", response.MIMEType);
    return response.MIMEType;
}

/*
 * iOS9.0后获取指定URL的MIMEType类型
 */
- (void)mimeTypeAfter_iOS_9_0:(void (^)(NSString *mimeType))mimeTypeBlock
{
    NSURL *url = [NSURL URLWithString:self];
    //1NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2NSURLConnection
    
    //3 在NSURLResponse里，服务器告诉浏览器用什么方式打开文件。
    
    //使用同步方法后去MIMEType
    [[NSURLSession alloc] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"---%@", response.MIMEType);
        mimeTypeBlock(response.MIMEType);
    }];
}

/**
 *  除去字符串中的第一个匹配的子字符串
 *
 *  @param str 要删除的子字符串
 *
 *  @return NSString
 */
- (NSString *)cutWithString:(NSString *)str
{
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound)
    {
        return self;
    }
    
    NSMutableString *src = [NSMutableString string];
    [src appendString:[self substringToIndex:range.location]];
    [src appendString:[self substringFromIndex:(range.location + range.length)]];
    return src;
}

/**
 *  返回首字母并且大写
 *
 *  @return 一个字母的字符串
 */
- (NSString *)uppercaseWithFirstChar
{
    NSMutableString *source = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *firstLetter = [source substringWithRange:NSMakeRange(0, 1)];
    return [firstLetter capitalizedString];
}

/**
 *  根据文字多少,格式大小绘制所需显示区域
 *
 *  @param textSize 文字显示区域
 *  @param fontSize 文字大小
 *
 *  @return 实际显示区域
 */
- (CGSize)getSizeWithTextSize:(CGSize)textSize
                         fontSize:(CGFloat)fontSize
{
    CGSize tempSize = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        tempSize = [self boundingRectWithSize:textSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]}
                                      context:nil].size;
    }
    else
    {
        NSDictionary *contentDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],
                                    NSFontAttributeName,
                                    [UIColor blackColor],
                                    NSForegroundColorAttributeName, nil];
        tempSize = [self boundingRectWithSize:textSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:contentDic
                                      context:nil].size;
    }
    return tempSize;
}

/**
 *  @author 刘克邪
 *
 *  @brief  将字符串转为UTF8编码
 *
 *  @return utf-8编码字符串
 */
- (NSString *)UTF8 {
    // [NSString stringByAddingPercentEncodingWithAllowedCharacters:]
    NSString *src = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, NULL, kCFStringEncodingUTF8));
    return src;
}

/**
 *  @author 刘克邪
 *
 *  @brief  将字符串转成NSDictionary
 *
 */
- (NSMutableDictionary *)dictionaryWithString {
    NSError *err;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return  nil;
    } else {
        return dic;
    }
}

@end
