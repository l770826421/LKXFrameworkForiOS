//
//  LKXTouchIDValidateTool.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2016/11/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTouchIDValidateTool.h"

@implementation LKXTouchIDValidateTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static LKXTouchIDValidateTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)sharedTouchIDValidateTool {
    return [[LKXTouchIDValidateTool alloc] init];
}

/**
 开始启用Touch ID验证

 @param supportFailure 不支持Touch ID验证
 @param successBlock 验证成功
 @param validateFailure 验证失败
 */
- (void)touchValidateSupportFailure:(void(^)(LAError errorCode))supportFailure success:(void (^)(void))successBlock validateFailure:(void (^)(LAError errorCode))validateFailure {
    // 初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    NSString *result = @"我的Touch ID";
    
    // 先判断设备是否支持Touch ID
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // 支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                successBlock();
            } else {
                validateFailure(error.code);
            }
        }];
    } else {    // 不支持指纹识别,log出错误详情
        supportFailure(error.code);
    }
}

@end
