//
//  LKXApplicationInfo.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <sys/sysctl.h>

#import "LKXApplicationInfo.h"

@interface LKXApplicationInfo ()

/** app的info.plist的字典 */
@property (nonatomic, strong) NSDictionary *appInfoDic;

@end

@implementation LKXApplicationInfo

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    static LKXApplicationInfo *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  @author 刘克邪
 *
 *  @brief  单例
 *
 */
+ (instancetype)sharedApplicationInfo {
    
    LKXApplicationInfo *info = [[[self class] alloc] init];
    return info;
}

- (NSDictionary *)appInfoDic {
    
    if (!_appInfoDic) {
        _appInfoDic = [[NSBundle mainBundle] infoDictionary];
//        CFShow((__bridge CFTypeRef)(_appInfoDic));
    }
    return _appInfoDic;
}

/** app名称 */
- (NSString *)appName {
    
    NSString *appName = [self.appInfoDic objectForKey:@"CFBundleName"];
    return appName;
}

/** app版本 */
- (NSString *)appVersion {
    
    return [self.appInfoDic objectForKey:@"CFBundleShortVersionString"];
}

/** app build版本 */
- (NSString *)appBulid {
    
    return [self.appInfoDic objectForKey:@"CFBundleVersion"];
}

/** app 手机序列号 */
- (NSString *)identfierNumber {
    
    NSString *indentifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return indentifierNumber;
}

/** 手机别名,用户定义的名称 */
- (NSString *)userPhoneName {
    
    NSString *userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}

/** 设备名称 */
- (NSString *)deviceName {
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    NSString *deviceName = nil;
    
    if ([platform isEqualToString:@"iPhone1,1"]) // iPhone 2G
        deviceName = @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"])
        deviceName = @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"])
        deviceName = @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"])
        deviceName = @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"])
        deviceName = @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"])
        deviceName = @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"])
        deviceName = @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"])
        deviceName = @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"])
        deviceName = @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"])
        deviceName = @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"])
        deviceName = @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"])
        deviceName = @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"])
        deviceName = @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"])
        deviceName = @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"])
        deviceName = @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])
        deviceName = @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])
        deviceName = @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])
        deviceName = @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])
        deviceName = @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])
        deviceName = @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])
        deviceName = @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])
        deviceName = @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])
        deviceName = @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])
        deviceName = @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])
        deviceName = @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])
        deviceName = @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])
        deviceName = @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])
        deviceName = @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])
        deviceName = @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])
        deviceName = @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])
        deviceName = @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])
        deviceName = @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])
        deviceName = @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])
        deviceName = @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])
        deviceName = @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])
        deviceName = @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])
        deviceName = @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])
        deviceName = @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])
        deviceName = @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])
        deviceName = @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])
        deviceName = @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])
        deviceName = @"iPhone Simulator";
    
    NSRange range = [deviceName rangeOfString:@"("];
    if (range.location != NSNotFound) {
        deviceName = [deviceName substringToIndex:range.location];
    }
    
    return deviceName;
    
//    NSString *deviceName = [[UIDevice currentDevice] systemName];
//    return deviceName;
}

/** 手机系统版本 */
- (NSString *)phoneVersion {
    
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}

/** 手机型号 */
- (NSString *)phoneModel {
    
    NSString *phoneModel = [[UIDevice currentDevice] model];
    return phoneModel;
}

/** 地方型号(国际化区域名称) */
- (NSString *)localPhoneModel {
    
    NSString *localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}

/** 当前应用名称 */
- (NSString *)appCurrentName {
    
    NSString *appCurVersion = [self.appInfoDic objectForKey:@"CFBundleName"];
    return appCurVersion;
}

/** 当前应用软件版本 */
- (NSString *)appCurrentVersion {
    
    NSString *appCurrentVersion = [self.appInfoDic objectForKey:@"CFBundleShortVersionString"];
    return appCurrentVersion;
}

/** 当前应用版本号码 */
- (NSNumber *)appCurrentVersionNumber {
    
    NSNumber *appcurrentVersionNumber = [self.appInfoDic objectForKey:@"CFBundleVersion"];
    return appcurrentVersionNumber;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<%@:%p>,\n app名称 = %@,\n app版本 = %@,\n app build版本 = %@,\n 当前应用名称 = %@,\n 当前应用软件版本,比如1.4.0 = %@,\n 当前应用版本号码 = %@,\n app 手机序列号 = %@,\n 手机别名,用户定义的名称 = %@,\n 设备名称 = %@,\n 手机系统版本 = %@,\n 手机型号 = %@,\n 地方型号(国际化区域名称) = %@", NSStringFromClass([self class]), self, self.appName, self.appVersion, self.appBulid, self.appCurrentName, self.appCurrentVersionNumber, self.appCurrentVersionNumber, self.identfierNumber, self.userPhoneName, self.deviceName, self.phoneVersion, self.phoneModel, self.localPhoneModel];
}

#pragma mark - other
/**
 检测是否是最新版本,如果是则提示去商城更新
 */

/**
 检测是否是最新版本,如果是则提示去商城更新

 @param appID 本应用在App Store的app id
 @return YES->可以更新;NO->不能更新。
 */
+ (BOOL)checkVersion:(NSString *)appID {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", appID];
    // 获取发布版本的version
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
    if (string != nil && string.length > 0 && [string rangeOfString:@"version"].length == 7) {
        return [self checkAppPrompt:string];
    } else {
        return NO;
    }
}
/**
 比较当前版本与新上线版本做比较

 @param appInfo 上线版本的页面信息
 @return YES->可以更新;NO->不能更新。
 */
+ (BOOL)checkAppPrompt:(NSString *)appInfo {
    // 获取当前版本
    NSString *currentVersion = [[LKXApplicationInfo sharedApplicationInfo] appCurrentVersion];
    // 线上版本
    NSString *versionOnline = [appInfo substringFromIndex:[appInfo rangeOfString:@"\"version\":"].location + 10];
    versionOnline = [[versionOnline substringToIndex:[versionOnline rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    // 判断,如果当前版本与发布的版本不相同,则提示；否则跳过。
    // 线上版本必须必当前版本高,因为审核最新版本时,比线上版本高
    if ([versionOnline compare:currentVersion] == NSOrderedDescending) {
        return YES;
    } else {
        return NO;
    }
}

@end
