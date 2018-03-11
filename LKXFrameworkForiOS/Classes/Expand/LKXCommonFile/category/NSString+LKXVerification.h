//
//  NSString+LKXVerification.h
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LKXVerification)

/**
 * YES 验证成功
 * NO  验证失败
 */

/**
*  邮箱验证
*
*  @return YES -- 成功, NO -- 失败
*/
- (BOOL)lkx_verificationEmail;

/**
 *  手机验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)lkx_verificationMobile;

/**
 *  固定电话验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)lkx_verificationFixedTelephone;

/**
 *  车牌号验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)lkx_verificationCarNumber;

/**
 *  身份证验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)lkx_verificationPersonID;

/**
 *  数字字符串验证
 *
 *  @return YES -- 成功, NO -- 失败
 */
- (BOOL)lkx_verificationDigitalString;

// 密码验证（字母和数字组合）
- (BOOL)lkx_verificationEnglishWithNumber;

@end
