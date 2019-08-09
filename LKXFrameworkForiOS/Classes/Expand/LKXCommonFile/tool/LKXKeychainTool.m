//
//  LKXKeyChainTool.m
//  LKXTestDemo
//
//  Created by lkx on 6/6/2019.
//  Copyright © 2019 刘克邪. All rights reserved.
//

#import "LKXKeychainTool.h"

#import "LKXApplicationInfo.h"

/**
 kSecClass:键值,指定其值为项的字典键类代码。使用此键获取或设置cftyperef类型的值包含项类代码的;
 kSecClass:value值,有以下值
 kSecClassInternetPassword 互联网密码.
 kSecClassGenericPassword 指定通用密码项.
 kSecClassCertificate 指定证书项.
 kSecClassKey 指定关键项.
 kSecClassIdentity 指定标识项.
 
 kSecAttrAccessible:钥匙串保护类型,以下是保护类型的值:
 kSecAttrAccessibleAfterFirstUnlock:开机之后密钥不可用,直到用户首次输入密码
 kSecAttrAccessibleAlways:密钥在设备开机后依旧可用.注意,在iOS9中被弃用,因为它相比kSecAttrAccessibleAfterFirstUnlock没有什么优势.
 kSecAttrAccessibleAlwaysThisDeviceOnly:密钥始终可用,但无法迁移到其他iOS设备
 kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly:作用同上,只能储存在当前设备
 kSecAttrAccessibleWhenUnlocked:只要解锁过设备(即用户已经输入过密码),那么秘钥将保持可用状态
 kSecAttrAccessibleWhenUnlockedThisDeviceOnly:作用同上,只能储存在当前设备(除非进行完成的加密设备)
 kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly:作用同上,只有用户设置密码密钥才可用:一旦取消密码,密钥将从设备中删除,并且不会保存在任何备份中
 
 
 
 kSecAttrLabel: 指定其值为标签属性,项的标签属性。使用此键设置或获取值键入cfStringRef，其中包含此项的用户可见标签。
 kSecAttrDescription:指定值为的字典键项的描述属性。使用此键设置或获取表示用户可见字符串的cfStringRef类型的值描述此特定类型的项目（例如，“磁盘映像密码”）。
 kSecAttrAccount:指定其值为项目的帐户属性。使用此键设置或获取cfStringRef包含帐户名的。（类别项目kSecClassGenericPassword，kSecClassInternetPassword有这个属性。）通过这个key值获取value值.
 kSecAttrService:指定其值为项的服务属性。使用此键设置或获取cfStringRef表示与此项关联的服务。（类别项目kSecClassGenericPassword具有此属性。）
 */

/**
 同步到iCloud
 [dict setObject:(__bridge id)kCFBooleanTrue
          forKey:(__bridge id)kSecAttrSynchronizable];
 使用此选项无法兼容kSecAttrAccessible,例如kSecAttrAccessibleWhenUnlockedThisDeviceOnly
 */

@implementation LKXKeychainTool

/**
 这里是基本的钥匙串信息

 @param key key值
 @return 钥匙串的字典信息
 */
+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)key {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:(__bridge id)kSecClassGenericPassword
             forKey:(__bridge id)kSecClass];
//    [dict setObject:@"test password"
//             forKey:(__bridge id)kSecAttrLabel];
//    [dict setObject:@"这个密码来自客户端"
//             forKey:(__bridge id)kSecAttrDescription];
    [dict setObject:key
             forKey:(__bridge id)kSecAttrAccount];
    [dict setObject:[LKXApplicationInfo sharedApplicationInfo].bundleID
             forKey:(__bridge id)kSecAttrService];
    [dict setObject:(__bridge id)kSecAttrAccessibleWhenUnlocked
             forKey:(__bridge id)kSecAttrAccessible];
    return dict;
}

/**
 存储字符串到钥匙串中
 
 @param value 对应的value
 @param key 对应的key
 @param errorStatus 保存失败的错误码
 @return 是否保存成功
 */
+ (BOOL)saveKeyChainValue:(NSString *)value
                      key:(NSString *)key
                    error:(void (^)(OSStatus errorStatus))errorStatus {
    NSMutableDictionary *dict = [self getKeyChainQuery:key];
    
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dict setObject:valueData
             forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dict, NULL);
    if (status == errSecSuccess) {
        return YES;
    } else {
        if (errorStatus) {
            errorStatus(status);
        }
        return NO;
    }
}

/**
 更新字符串到钥匙串中
 
 @param value 对应的value
 @param key 对应的key
 @param errorStatus 保存失败的错误码
 @return 是否更新成功
 */
+ (BOOL)updateKeyChainValue:(NSString *)value
                        key:(NSString *)key
                      error:(void (^)(OSStatus errorStatus))errorStatus {
    NSMutableDictionary *originDict = [self getKeyChainQuery:key];
    NSMutableDictionary *updateDict = [NSMutableDictionary dictionary];
    
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [updateDict setObject:valueData
                   forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)originDict, (__bridge CFDictionaryRef)updateDict);
    if (status == errSecSuccess) {
        return YES;
    } else {
        if (errorStatus) {
            errorStatus(status);
        }
        return NO;
    }
}

/**
 在钥匙串中根据key读取值
 
 @param key 对应的key值
 @param errorStatus 保存失败的错误码
 @return 对应的value
 */
+ (NSString *)readKeyChainValueWithKey:(NSString *)key
                                 error:(void (^)(OSStatus errorStatus))errorStatus {
    NSMutableDictionary *dict = [self getKeyChainQuery:key];
    [dict setObject:(__bridge id)kCFBooleanTrue
             forKey:(__bridge id)kSecReturnData];
    CFDataRef data = NULL;
    NSString *result = nil;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dict, (CFTypeRef *)&data);
    if (status == errSecSuccess) {
        result = [[NSString alloc] initWithData:(__bridge NSData *)data
                                       encoding:NSUTF8StringEncoding];
    } else {
        if (errorStatus) {
            errorStatus(status);
        }
    }
    
    if (data) {
        CFRelease(data);
    }
    
    return result;
}

/**
 在钥匙串中根据key读取值
 
 @param key 对应的key值
 @param errorStatus 保存失败的错误码
 @return 是否删除成功
 */
+ (BOOL)deleteKeyChainValueWithKey:(NSString *)key
                             error:(void (^)(OSStatus errorStatus))errorStatus {
    NSMutableDictionary *dict = [self getKeyChainQuery:key];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dict);
    if (status == errSecSuccess) {
        return YES;
    } else {
        if (errorStatus) {
            errorStatus(status);
        }
        return NO;
    }
}

@end
