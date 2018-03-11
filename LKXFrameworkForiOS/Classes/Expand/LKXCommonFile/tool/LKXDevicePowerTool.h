//
//  LKXDevicePowerTool.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/3/14.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCellularData.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>

/**
 相册权限

 - LKXAssetsLibraryStatusAuthorized: 经授权的
 - LKXAssetsLibraryStatusDenied: 无权限的
 - LKXAssetsLibraryStatusNotDetermined: 不确定
 - LKXAssetsLibraryStatusRestricted: 受限制的
 */
typedef NS_ENUM(NSInteger, LKXAssetsLibraryStatus) {
    LKXAssetsLibraryStatusAuthorized,
    LKXAssetsLibraryStatusDenied,
    LKXAssetsLibraryStatusNotDetermined,
    LKXAssetsLibraryStatusRestricted
};

/**
 通讯录权限

 - LKXAdressBookStatusAuthorized: 经授权
 - LKXAdressBookStatusDenied: 无权限
 - LKXAdressBookStatusNotDetermined: 不确定的
 - LKXAdressBookStatusRestricted: 受限制的
 */
typedef NS_ENUM(NSInteger, LKXAdressBookStatus) {
    LKXAdressBookStatusAuthorized,
    LKXAdressBookStatusDenied,
    LKXAdressBookStatusNotDetermined,
    LKXAdressBookStatusRestricted
};

/**
 检测设备权限工具类
 */
@interface LKXDevicePowerTool : NSObject

/**
 检测推送权限
 */
+ (BOOL)testUserNotificationPower;

/**
 获取推送权限
 */
+ (void)requireUserNotificationPower;

/**
 检测应用中是否有联网权限
 
 @param stateBlock 联网权限状态
 */
+ (void)testNetWorkPowerState:(void(^ _Nonnull)(CTCellularDataRestrictedState state))stateBlock;

/**
 查询应用的联网功能
 */
+ (CTCellularDataRestrictedState)queryNetWorkState;

/**
 检测相册权限
 */
+ (LKXAssetsLibraryStatus)testAssetsLibraryPower;

/**
 获取相册权限,只能在系统大于8.0下使用
 */
+ (void)requireAssetsLibraryPower:(void(^ _Nonnull)(LKXAssetsLibraryStatus status))statusBlock;

/**
 检查对应的media权限
 
 @param mediaType 对应权限的Type,AVMediaTypeVideo -> 相机权限; AVMediaTypeAudio -> 麦克风权限
 */
+ (AVAuthorizationStatus)testMediaTypePowerWithMediaType:(NSString * _Nullable)mediaType;

/**
 获取对应的Media权限
 
 @param mediaType  对应的mediaType字符串
 @param completionHandler 获取权限的结果
 */
+ (void)requireMediaPowerWithMediaType:(NSString * _Nullable)mediaType completionHandler:(void(^ _Nonnull)(bool granted))completionHandler;

/**
 获取定位权限
 
 在代理方法中查看权限是否改变
 - (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
 */
+ (CLAuthorizationStatus)testLocationPower;

/**
 获取定位权限
 */
+ (void)requireLocationPower;

/**
 检测是否有通讯录权限
 */
+ (LKXAdressBookStatus)testAddressBookPower;

/**
 获取通讯录权限
 */
+ (void)requireAddressBookPowerCompletion:(void(^ _Nonnull)(BOOL granted, NSError * _Nonnull error))completion;

/**
 检查日历或备忘录权限
 
 @param entityType 日历或者备忘录枚举值
 @return 权限
 */
+ (EKAuthorizationStatus)testEntityPowerWithEntityType:(EKEntityType)entityType;

/**
 获取日历或者备忘录权限
 
 @param entityType 日历或者备忘录枚举值
 @param completion 获取结果
 */
+ (void)requireEntityPowerWithEntityType:(EKEntityType)entityType completion:(void(^_Nullable)(BOOL granted, NSError * _Nullable error))completion;

@end
