//
//  LKXApplicationInfo.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author 刘克邪
 *
 *  @brief  获取APP李action的Info.plist的信息
 */
@interface LKXApplicationInfo : NSObject

/**
 *  @author 刘克邪
 *
 *  @brief  单例
 *
 */
+ (instancetype)sharedApplicationInfo;

/** app名称 */
@property (nonatomic, copy, readonly) NSString *appName;

/** app版本 */
@property (nonatomic, copy, readonly) NSString *appVersion;

/** app build版本 */
@property (nonatomic, copy, readonly) NSString *appBulid;

/** 当前应用名称 */
@property (nonatomic, copy, readonly) NSString *appCurrentName;

/** 当前应用软件版本,比如1.4.0 */
@property (nonatomic, copy, readonly) NSString *appCurrentVersion;

/** 当前应用版本号码 */
@property (nonatomic, strong, readonly) NSNumber *appCurrentVersionNumber;

/** app 手机序列号 */
@property (nonatomic, copy, readonly) NSString *identfierNumber;

/** 手机别名,用户定义的名称 */
@property (nonatomic, copy, readonly) NSString *userPhoneName;

/** 设备名称 */
@property (nonatomic, copy, readonly) NSString *deviceName;

/** 手机系统版本 */
@property (nonatomic, copy, readonly) NSString *phoneVersion;

/** 手机型号 */
@property (nonatomic, copy, readonly) NSString *phoneModel;

/** 地方型号(国际化区域名称) */
@property (nonatomic, copy, readonly) NSString *localPhoneModel;

#pragma mark - other
/**
 检测是否是最新版本,如果是则提示去商城更新
 */

/**
 检测是否是最新版本,如果是则提示去商城更新
 
 @param appID 本应用在App Store的app id
 @return YES->可以更新;NO->不能更新。
 */
+ (BOOL)checkVersion:(NSString *)appID;

@end
