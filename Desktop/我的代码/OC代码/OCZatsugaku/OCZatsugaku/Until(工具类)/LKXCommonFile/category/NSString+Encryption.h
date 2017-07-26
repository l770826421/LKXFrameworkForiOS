//
//  NSString+Encryption.h
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author lkx
 *
 *  @brief  加密扩展
 */
@interface NSString (Encryption)

// 大写加密
- (NSString *)encryptionWithMD5For16Bit_uppercase;

/**
 *  @author lkx
 *
 *  @brief  MD5大写加密
 *
 *  @param length 加密长度
 *
 *  @return 加密后的数据
 */
- (NSString *)encryptionWithMD5WithBit_uppercase:(NSInteger)length;

// 小写加密
- (NSString *)encryptionWithMD5For16Bit_lowercase;

/**
 *  @author lkx
 *
 *  @brief  MD5小写加密
 *
 *  @param length 加密长度
 *
 *  @return 加密后的数据
 */
- (NSString *)encryptionWithMD5WithBit_lowercase:(NSInteger)length;

#pragma mark - SHA1加密
/**
 *  @author 刘克邪
 *
 *  @brief  SHA1 32位加密
 *
 *  @return SHA1 32位加密后的字符串
 */
- (NSString *)encryptionSha1WithFor40Bit_uppercase;

@end
