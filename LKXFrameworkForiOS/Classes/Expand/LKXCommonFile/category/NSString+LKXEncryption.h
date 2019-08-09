//
//  NSString+LKXEncryption.h
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

/**
 *  @author lkx
 *
 *  @brief  加密扩展
 */
@interface NSString (LKXEncryption)

#pragma mark - Hash加密

/**
 MD5加密
 
 @return MD5加密后的密文
 */
- (NSString *)lkx_MD5Encrypt;

/**
 *  @author 刘克邪
 *
 *  @brief  SHA1加密
 *
 *  @return SHA1加密后的字符串
 */
- (NSString *)lkx_SHA1Encrypt;

/**
 SHA224加密,不可逆
 
 @return SHA224密文字符串
 */
- (NSString *)lkx_SHA224Encrypt;

/**
 SHA256加密,不可逆
 
 @return SHA256密文字符串
 */
- (NSString *)lkx_SHA256Encrypt;

/**
 SHA384加密,不可逆
 
 @return SHA384密文字符串
 */
- (NSString *)lkx_SHA384Encrypt;

/**
 SHA512加密,不可逆
 
 @return SHA512密文字符串
 */
- (NSString *)lkx_SHA512Encrypt;

#pragma mark - DES加密
/**
 DES加密

 @param operation 加密/解密选择
 @param key 密钥,加密/解密必须一致
 @return 加密/解密结果
 */
- (NSString *)lkx_DESEncryptionWithEncryptOrDecryptOperation:(CCOperation)operation
                                                         key:(NSString *)key;

#pragma mark - AES加密解密

/**
 AES加密

 @param key 密钥
 @return 加密结果,结果是base64字符串
 */
- (NSString *)lkx_AES256EncryptWithKey:(NSString *)key;

/**
 AES解密

 @param key 密钥
 @return 返回明文
 */
- (NSString *)lkx_AES256DecryptWithKey:(NSString *)key;

@end
