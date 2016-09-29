//
//  NSString+Verification.h
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verification)

/**
 * YES 验证成功
 * NO  验证失败
 */

/**
*  邮箱验证
*
*  @return YES -- 成功, NO -- 失败
*/
- (BOOL)verificationEmail;

/**
 *  手机验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationMobile;

/**
 *  固定电话验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationFixedTelephone;

/**
 *  车牌号验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationCarNumber;

/**
 *  身份证验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationPersonID;

/**
 *  数字字符串验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)verificationDigitalString;

// 密码验证（字母和数字组合）
- (BOOL)verificationEnglishWithNumber;

@end
