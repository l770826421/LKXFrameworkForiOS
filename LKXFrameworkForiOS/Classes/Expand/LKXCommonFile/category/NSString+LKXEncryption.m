//
//  NSString+LKXEncryption.m
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>

#import "NSString+LKXEncryption.h"
#import "NSString+LKXCategory.h"
#import "GTMBase64.h"
#import "NSData+LKXCategory.h"

static inline NSString *NSStringCCHashFunction(unsigned char *(function)(const void *data, CC_LONG len, unsigned char *md), CC_LONG digestLength, NSString *string) {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 分配密文内存空间
    uint8_t digest[digestLength];
    // 加密
    function(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:digestLength * 2];
    for (int i = 0; i < digestLength; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@implementation NSString (LKXEncryption)

#pragma mark - Hash加密

/**
 MD5加密

 @return MD5加密后的密文
 */
- (NSString *)lkx_MD5Encrypt
{
    return NSStringCCHashFunction(CC_MD5, CC_MD5_DIGEST_LENGTH, self);
}

/**
 *  @author 刘克邪
 *
 *  @brief  SHA1加密
 *
 *  @return SHA1加密后的字符串
 */
- (NSString *)lkx_SHA1Encrypt {
    return NSStringCCHashFunction(CC_SHA1, CC_SHA1_DIGEST_LENGTH, self);
}

/**
 SHA224加密,不可逆
 
 @return SHA224密文字符串
 */
- (NSString *)lkx_SHA224Encrypt {
    return NSStringCCHashFunction(CC_SHA224, CC_SHA224_DIGEST_LENGTH, self);
}

/**
 SHA256加密,不可逆
 
 @return SHA256密文字符串
 */
- (NSString *)lkx_SHA256Encrypt {
    return NSStringCCHashFunction(CC_SHA256, CC_SHA256_DIGEST_LENGTH, self);
}

/**
 SHA384加密,不可逆
 
 @return SHA384密文字符串
 */
- (NSString *)lkx_SHA384Encrypt {
    return NSStringCCHashFunction(CC_SHA384, CC_SHA384_DIGEST_LENGTH, self);
}

/**
 SHA512加密,不可逆
 
 @return SHA512密文字符串
 */
- (NSString *)lkx_SHA512Encrypt {
    return NSStringCCHashFunction(CC_SHA512, CC_SHA512_DIGEST_LENGTH, self);
}

#pragma mark - DES加密
/**
 DES加密
 
 @param operation 加密/解密选择
 @param key 密钥,加密/解密必须一致
 @return 加密/解密结果
 */
- (NSString *)lkx_DESEncryptionWithEncryptOrDecryptOperation:(CCOperation)operation
                                                         key:(NSString *)key{
    const void *dataIn; // 加密/解密的输入数据,加密则是明文,解密则是加密后的密文
    size_t dataInLength;    // 加密/解密的数据长度
    
    if (operation == kCCDecrypt) {  // 解密
        NSData *decryptData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    } else {  // 加密
        NSData *encryptData = [self dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    
    /**
     DES加密: 用CCCrypt函数加密,然后用base64编码
     DES解密: 把收到的数据根据base64 decode一下,然后再用CCCrypt函数解密,得到原本的数据
     */
    CCCryptorStatus ccStatus;
    // 可以理解位type/typedef的缩写(有效的维护了代码,比如:一个人用int,一个人用long.最好用typedef来定义)
    // 输出值
    uint8_t *dataOut = NULL;
    // size_t是操作符sizeof返回的结果类型
    // 输出值的有效长度
    size_t dataOutAvailable = 0;
    // 输出值的偏移量
    size_t dataOutMoved = 0;
    // 开辟内存空间
    // 计算空间长度
    // ~ 按位取反
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc(dataOutAvailable * sizeof(uint8_t));
    // 将以开辟内存空间的buffer的第一个字节的值设置为o0
    memset((void *)dataOut, 0x0, dataOutAvailable);
    
    NSString *initIv = @"12345678";
    const void *vkey = (const void *)[key UTF8String];
    const void *iv = (const void *)[initIv UTF8String];
    
    // CCCrypt函数 加密/解密
    ccStatus = CCCrypt(operation, // 加密/解密
                       kCCAlgorithmDES, // 加密标准(DES, 3DES, AES...)
                       kCCOptionPKCS7Padding, // 选项分组密码算法(DES:对每块分组加一次密,3DES:对每块分组加三次不同的密)
                       vkey, // 密钥,加密和解密的密钥必须一致
                       kCCKeySizeDES, // DES密钥的大小(kCCKeySizeDES = 8)
                       iv, // 可选的初始矢量
                       dataIn, // 原始数据的存储单元
                       dataInLength, // 数据大小
                       (void *)dataOut, // 存储返回数据
                       dataOutAvailable, // 返回数据的大小
                       &dataOutMoved);
    
    NSData *nsDataOut = [NSData dataWithBytes:(const void *)dataOut
                                       length:(NSUInteger)dataOutMoved];
    NSString *result = nil;
    if (operation == kCCDecrypt) { // 解码
        result = [[NSString alloc] initWithData:nsDataOut encoding:NSUTF8StringEncoding];
    } else { // 加密
        // 这里必须转base64,不能直接转NSString
//        result = [GTMBase64 stringByEncodingData:nsDataOut];
        result = [nsDataOut lkx_toBase64String];
    }
    
    
    
    return result;
}

#pragma mark - AES加密解密

/**
 AES加密
 
 @param key 密钥
 @return 加密结果
 */
- (NSString *)lkx_AES256EncryptWithKey:(NSString *)key {
    NSString *result = nil;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    char keyPtr[kCCKeySizeAES256]; // 密钥
    bzero(keyPtr, sizeof(keyPtr));
    // 将NSString密钥转为char数组
    BOOL success = [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    if (success) {
        NSUInteger dataLength = [data length];
        // 计算加密结果长度
        size_t bufferSize = dataLength + kCCBlockSizeAES128;
        // 分配加密结果内存空间
        void *buffer = malloc(bufferSize);
        size_t numBytesEncrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                              kCCAlgorithmAES128,
                                              kCCOptionPKCS7Padding | kCCOptionECBMode,
                                              keyPtr,
                                              kCCBlockSizeAES128,
                                              NULL,
                                              [data bytes],
                                              dataLength,
                                              buffer,
                                              bufferSize,
                                              &numBytesEncrypted);
        
        if (cryptStatus == kCCSuccess) {
            NSData *outData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
            result = [outData lkx_toBase64String];
            return result;
        }
        free(buffer);
    }
    
    return result;;
}

/**
 AES解密
 
 @param key 密钥
 @return 返回明文
 */
- (NSString *)lkx_AES256DecryptWithKey:(NSString *)key {
    NSString *result = nil;
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    char keyPtr[kCCKeySizeAES256]; // 密钥
    bzero(keyPtr, sizeof(keyPtr));
    BOOL success = [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    if (success) {
        NSUInteger dataLength = [data length];
        // 计算明文空间长度
        size_t bufferSize = dataLength + kCCBlockSizeAES128;
        // 分配明文内存空间
        void *buffer = malloc(bufferSize);
        size_t numBytesDecrypted = 0;
        CCCryptorStatus ccStatus = CCCrypt(kCCDecrypt,
                                           kCCAlgorithmAES128,
                                           kCCOptionPKCS7Padding | kCCOptionECBMode,
                                           keyPtr,
                                           kCCBlockSizeAES128,
                                           NULL,
                                           [data bytes],
                                           dataLength,
                                           buffer, bufferSize,
                                           &numBytesDecrypted);
        
        if (ccStatus == kCCSuccess) {
            NSData *outData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
            NSString *base64String = [outData lkx_toBase64String];
            result = [base64String lkx_base64StringToString];
            return result;
        }
        
        free(buffer);
    }
    
    return result;
}


@end
