//
//  NSString+Verification.m
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "NSString+Verification.h"

@implementation NSString (Verification)

/**
 *  邮箱验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}

/**
 *  手机验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationMobile
{
    //^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$ ^((13[0-9])|(15[^4,\\D])|(17[0])|(18[0,0-9]))\\d{8}$
    NSString *phoneRegex = @"^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8]))\\d{8}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phonePredicate evaluateWithObject:self];
}

/**
 *  固定电话验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationFixedTelephone
{
    // (?:(\\(\\+?86\\))(0[0-9]{2,3}\\-?)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?)|(?:(86-?)?(0[0-9]{2,3}\\-?)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?)
    NSString *phoneRegex = @"(?:(\\(\\+?86\\))(0[0-9]{2,3}\\-?)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?)|(?:(86-?)?(0[0-9]{2,3}\\-?)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?)";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phonePredicate evaluateWithObject:self];
}

/**
 *  车牌号验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationCarNumber
{
    NSString *carNumberRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carNumberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carNumberRegex];
    return [carNumberPredicate evaluateWithObject:self];
}

/**
 *  省份证验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationPersonID
{
    NSString *persionIDRegex = @"^[0-9]{17}[0-9|xX]{1}$";
    NSPredicate *persionIDPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",persionIDRegex];
    return [persionIDPredicate evaluateWithObject:self];
}

/**
 *  数字字符串验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationDigitalString
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [predicate evaluateWithObject:self];
    return isMatch;
}

// 密码验证（字母和数字组合）
- (BOOL)verificationEnglishWithNumber {
    NSString *regex = @"^[A-Za-z]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [predicate evaluateWithObject:self];
    return isMatch;
}

@end
