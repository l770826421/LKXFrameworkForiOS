//
//  LKXKeyChainTool.h
//  LKXTestDemo
//
//  Created by lkx on 6/6/2019.
//  Copyright © 2019 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 相同公开库有LockBox
@interface LKXKeychainTool : NSObject

/**
 存储字符串到钥匙串中

 @param value 对应的value
 @param key 对应的key
 @param errorStatus 保存失败的错误码
 @return 是否保存成功
 */
+ (BOOL)saveKeyChainValue:(NSString *)value
                      key:(NSString *)key
                    error:(void (^)(OSStatus errorStatus))errorStatus;

/**
 更新字符串到钥匙串中
 
 @param value 对应的value
 @param key 对应的key
 @param errorStatus 保存失败的错误码
 @return 是否更新成功
 */
+ (BOOL)updateKeyChainValue:(NSString *)value
                        key:(NSString *)key
                      error:(void (^)(OSStatus errorStatus))errorStatus;

/**
 在钥匙串中根据key读取值

 @param key 对应的key值
 @param errorStatus 保存失败的错误码
 @return 对应的value
 */
+ (NSString *)readKeyChainValueWithKey:(NSString *)key
                                 error:(void (^)(OSStatus errorStatus))errorStatus;

/**
 在钥匙串中根据key读取值
 
 @param key 对应的key值
 @param errorStatus 保存失败的错误码
 @return 是否删除成功
 */
+ (BOOL)deleteKeyChainValueWithKey:(NSString *)key
                             error:(void (^)(OSStatus errorStatus))errorStatus;

@end

NS_ASSUME_NONNULL_END
