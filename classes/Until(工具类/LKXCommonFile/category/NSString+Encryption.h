//
//  NSString+Encryption.h
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)

// 大写加密
- (NSString *)encryptionWithMD5For16Bit_uppercase:(NSString *)str;

// 大写加密
- (NSString *)encryptionWithMD5For16Bit_lowercase:(NSString *)str;

@end
