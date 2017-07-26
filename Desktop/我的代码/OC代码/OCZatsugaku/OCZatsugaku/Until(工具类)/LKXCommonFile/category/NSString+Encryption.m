//
//  NSString+Encryption.m
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>

#import "NSString+Encryption.h"

@implementation NSString (Encryption)

#pragma mark - MD5 16位加密
// 大写加密
- (NSString *)encryptionWithMD5For16Bit_uppercase
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 *  @author lkx
 *
 *  @brief  MD5大写加密
 *
 *  @param length 加密长度
 *
 *  @return 加密后的数据
 */
- (NSString *)encryptionWithMD5WithBit_uppercase:(NSInteger)length
{
    NSMutableString *string = [NSMutableString string];
    
    const char *cStr = [self UTF8String];
    unsigned char result[length];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    for (int i = 0; i < length; i++)
    {
        [string appendFormat:@"%02X", result[i]];
    }
    
    return string;
}

// 小写加密
- (NSString *)encryptionWithMD5For16Bit_lowercase
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 *  @author lkx
 *
 *  @brief  MD5小写加密
 *
 *  @param length 加密长度
 *
 *  @return 加密后的数据
 */
- (NSString *)encryptionWithMD5WithBit_lowercase:(NSInteger)length
{
    NSMutableString *string = [NSMutableString string];
    
    const char *cStr = [self UTF8String];
    unsigned char result[length];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    for (int i = 0; i < length; i++)
    {
        [string appendFormat:@"%02x", result[i]];
    }
    
    return string;
}

#pragma mark - SHA1加密
/**
 *  @author 刘克邪
 *
 *  @brief  SHA1 32位加密
 *
 *  @return SHA1 32位加密后的字符串
 */
- (NSString *)encryptionSha1WithFor40Bit_uppercase {
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02X", digest[i]];
    }
    
    return output;
}



@end
