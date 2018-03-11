//
//  LKXTouchIDValidateTool.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 2016/11/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

/**
 Touch ID验证
 */
@interface LKXTouchIDValidateTool : NSObject

+ (instancetype)sharedTouchIDValidateTool;

/**
 开始启用Touch ID验证
 
 @param supportFailure 不支持Touch ID验证
 @param successBlock 验证成功
 @param validateFailure 验证失败
 */
- (void)touchValidateSupportFailure:(void(^)(LAError errorCode))supportFailure success:(void (^)(void))successBlock validateFailure:(void (^)(LAError errorCode))validateFailure;

@end
