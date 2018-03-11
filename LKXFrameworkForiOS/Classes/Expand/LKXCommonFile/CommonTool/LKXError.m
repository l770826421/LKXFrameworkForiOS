//
//  LKXError.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/8/1.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXError.h"

#import <objc/runtime.h>

static NSString * const kLocalizedDescription = @"lkx_localizedDescription";
static NSString *const kErrorDomain = @"com.lkx.error";

@implementation LKXError

/**
 *  @author 刘克邪
 *
 *  @brief  初始化错误对象
 *
 */
+ (instancetype)lkx_error {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Domain error" forKey:NSLocalizedDescriptionKey];
    LKXError *error = [LKXError errorWithDomain:kErrorDomain code:-1010101 userInfo:userInfo];
    return error;
}

/**
 *  @author 刘克邪
 *
 *  @brief  自定义设置错误信息
 *
 */
- (void)lkx_setUserInfo:(NSString *)info {
    objc_setAssociatedObject(self, (__bridge const void *)(kLocalizedDescription), info, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)userInfo {
    return @{NSLocalizedDescriptionKey : objc_getAssociatedObject(self, (__bridge const void *)(kLocalizedDescription))};
}


@end
