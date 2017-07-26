//
//  LKXDevicePowerTool.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/3/14.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXDevicePowerTool.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@implementation LKXDevicePowerTool

/**
 检测推送权限
 */
+ (BOOL)testUserNotificationPower {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (setting.types == UIUserNotificationTypeNone) {
        return NO;
    } else {
        return YES;
    }
}

/**
 获取推送权限
 */
+ (void)requireUserNotificationPower {
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}

/**
 检测应用中是否有联网权限

 @param stateBlock 联网权限状态
 */
+ (void)testNetWorkPowerState:(void(^)(CTCellularDataRestrictedState state))stateBlock {
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        stateBlock(state);
    };
}


/**
 查询应用的联网功能
 */
+ (CTCellularDataRestrictedState)queryNetWorkState {
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    return cellularData.restrictedState;
}

/**
 检测相册权限
 */
+ (LKXAssetsLibraryStatus)testAssetsLibraryPower {
    LKXAssetsLibraryStatus _status = LKXAssetsLibraryStatusAuthorized;
    if (Dev_IOSVersion > 8.0) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_8_0
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        switch (status) {
            case PHAuthorizationStatusAuthorized:
                _status = LKXAssetsLibraryStatusAuthorized;
                break;
            case PHAuthorizationStatusDenied:
                _status = LKXAssetsLibraryStatusDenied;
                break;
            case PHAuthorizationStatusNotDetermined:
                _status = LKXAssetsLibraryStatusNotDetermined;
                break;
            default:
                _status = LKXAssetsLibraryStatusRestricted;
                break;
        }
#endif
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED <= __IPHONE_8_0
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        switch (status) {
            case ALAuthorizationStatusAuthorized:
                _status = LKXAssetsLibraryStatusAuthorized;
                break;
            case ALAuthorizationStatusDenied:
                _status = LKXAssetsLibraryStatusDenied;
                break;
            case ALAuthorizationStatusNotDetermined:
                _status = LKXAssetsLibraryStatusNotDetermined;
                break;
            default:
                _status = LKXAssetsLibraryStatusRestricted;
                break;
        }
#endif
    }
    return _status;
}


/**
 获取相册权限,只能在系统大于8.0下使用
 */
+ (void)requireAssetsLibraryPower:(void(^)(LKXAssetsLibraryStatus status))statusBlock {
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_8_0
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        LKXAssetsLibraryStatus _status = LKXAssetsLibraryStatusAuthorized;
        switch (status) {
            case PHAuthorizationStatusAuthorized:
                _status = LKXAssetsLibraryStatusAuthorized;
                break;
            case PHAuthorizationStatusDenied:
                _status = LKXAssetsLibraryStatusDenied;
                break;
            case PHAuthorizationStatusNotDetermined:
                _status = LKXAssetsLibraryStatusNotDetermined;
                break;
            default:
                _status = LKXAssetsLibraryStatusRestricted;
                break;
        }
        statusBlock(_status);
    }];
#endif
}

/**
 检查对应的media权限

 @param mediaType 对应权限的Type,AVMediaTypeVideo -> 相机权限; AVMediaTypeAudio -> 麦克风权限
 */
+ (AVAuthorizationStatus)testMediaTypePowerWithMediaType:(NSString *)mediaType {
    AVAuthorizationStatus avStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    return avStatus;
}

/**
 获取对应的Media权限

 @param mediaType  对应的mediaType字符串
 @param completionHandler 获取权限的结果
 */
+ (void)requireMediaPowerWithMediaType:(NSString *)mediaType completionHandler:(void(^)(bool granted))completionHandler {
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        if (completionHandler) {
            completionHandler(granted);
        }
    }];
}


/**
 获取定位权限
 
 在代理方法中查看权限是否改变
 - (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
 */
+ (CLAuthorizationStatus)testLocationPower {
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        LKXMLog(@"没有定位服务功能");
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return status;
}


/**
 获取定位权限
 */
+ (void)requireLocationPower {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    [manager requestAlwaysAuthorization];
    [manager requestWhenInUseAuthorization];
}


/**
 检测是否有通讯录权限
 */
+ (LKXAdressBookStatus)testAddressBookPower {
    LKXAdressBookStatus _status = LKXAdressBookStatusDenied;
    if (Dev_IOSVersion < 9.0) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusDenied:
                _status = LKXAdressBookStatusDenied;
                break;
            case kABAuthorizationStatusAuthorized:
                _status = LKXAdressBookStatusAuthorized;
                break;
            case kABAuthorizationStatusRestricted:
                _status = LKXAdressBookStatusRestricted;
            default:
                _status = LKXAdressBookStatusNotDetermined;
                break;
        }
#endif
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusDenied:
                _status = LKXAdressBookStatusDenied;
                break;
            case CNAuthorizationStatusAuthorized:
                _status = LKXAdressBookStatusAuthorized;
                break;
            case CNAuthorizationStatusRestricted:
                _status = LKXAdressBookStatusRestricted;
                break;
            default:
                _status = LKXAdressBookStatusNotDetermined;
                break;
        }
#endif
    }
    return _status;
}

/**
 获取通讯录权限
 */
+ (void)requireAddressBookPowerCompletion:(void(^)(BOOL granted, NSError *error))completion {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (error) {
        LKXMLog(@"获取通讯录权限error:%@", error);
    }
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        NSError *err = (__bridge NSError *)(error);
        if (completion) {
            completion(granted, err);
        }
    });
#else 
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (completion) {
            completion(granted, error);
        }
    }];
#endif
}

/**
 检查日历或备忘录权限

 @param entityType 日历或者备忘录枚举值
 @return 权限
 */
+ (EKAuthorizationStatus)testEntityPowerWithEntityType:(EKEntityType)entityType {
    EKAuthorizationStatus ekStatus = [EKEventStore authorizationStatusForEntityType:entityType];
    return ekStatus;
}

/**
 获取日历或者备忘录权限

 @param entityType 日历或者备忘录枚举值
 @param completion 获取结果
 */
+ (void)requireEntityPowerWithEntityType:(EKEntityType)entityType completion:(void(^)(BOOL granted, NSError * _Nullable error))completion {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:entityType completion:^(BOOL granted, NSError * _Nullable error) {
        if (completion) {
            completion(granted, error);
        }
    }];
}

@end
