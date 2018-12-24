//
//  LKXUser.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXUser.h"
#import "NSObject+LKXRuntime.h"

@implementation LKXUser

MJCodingImplementation

/**
 异步初始化LKXUser
 
 @param dic 数据源字典
 @param completion 返回block
 */
+ (void)loadUserWithDictionary:(NSDictionary *)dic completion:(void (^)(LKXUser *user))completion {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        LKXUser *user = [LKXUser lkx_objectWithDictionary:dic];
        if (completion) {
            completion(user);
        }
    });
}

- (NSString *)description {
    NSArray *propertyList = @[@"name", @"age", @"hight"];
    
    return [self dictionaryWithValuesForKeys:propertyList].description;
}

- (void)run {
    LKXMLog(@"%s", __FUNCTION__);
}

- (void)eat {
    LKXMLog(@"%s ", __FUNCTION__);
}

- (instancetype)run1 {
    LKXMLog(@"%s", __FUNCTION__);
    return self;
}

- (instancetype)eat1 {
    LKXMLog(@"%s", __FUNCTION__);
    return self;
}

- (LKXUser * (^)())run2 {
//    void (^runBlock)() = ^{
//        LKXMLog(@"%s", __FUNCTION__);
//    };
//
//    return runBlock;
    
    LKXUser * (^runBlock)() = ^{
        LKXMLog(@"%s", __FUNCTION__);
        
        return self;
    };
    return runBlock;
}

- (LKXUser * (^)())eat2 {
    return ^{
        LKXMLog(@"%s", __FUNCTION__);
        
        return self;
    };
}

- (LKXUser * (^)(double distance))run3 {
    return ^(double distance) {
        LKXMLog(@"%s -- 跑%f", __FUNCTION__, distance);
        
        return self;
    };
}

- (LKXUser * (^)(NSString *food))eat3 {
    return ^(NSString *food) {
        LKXMLog(@"%s --- 吃%@", __FUNCTION__, food);
        
        return self;
    };
}

@end