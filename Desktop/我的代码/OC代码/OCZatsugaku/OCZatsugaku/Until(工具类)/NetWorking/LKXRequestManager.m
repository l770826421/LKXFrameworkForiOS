
//
//  LKXRequestManager.m
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXRequestManager.h"
#import "AFNetWorkingTool.h"
#import "NSDate+Formatter.h"

@interface LKXRequestManager ()

/** AFNetWorkingTool工具类 */
@property (nonatomic, strong) AFNetWorkingTool *afNetworkingTool;

@end

@implementation LKXRequestManager

/**
 *  @author 刘克邪
 *
 *  @brief  实现了LKXRequestManager的类单例创建
 *
 *  在分配空间的时候就实现单例初始化,实现了线程单例安全
 *
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static LKXRequestManager *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.afNetworkingTool = [AFNetWorkingTool shareAFNetWorkingTool];
    }
    return self;
}

/**
 *  @author 刘克邪
 *
 *  @brief  每一个单例必须以share开头
 *
 */
+ (instancetype)shareRequestManager {
    return [[self alloc] init];
}

/**
 *  @author 刘克邪
 *
 *  @brief  获取当前时间戳
 *
 */
- (NSTimeInterval)currentDate {
    NSDate *date = [NSDate date];
    NSTimeInterval timInterval = [date timeIntervalSince1970];
    return timInterval;
}

/**
 *  @author 刘克邪
 *
 *  @brief  获取当前时间戳的字符串
 *
 */
- (NSDictionary *)allParameters:(NSDictionary *)oldParameters {
    NSMutableDictionary *allParameters =
            [NSMutableDictionary dictionaryWithDictionary:oldParameters];

    NSString *str_timeItl =
            [[NSDate date] dateWithFormatter:Date_Formatter_YYYYMMddHHmmss];
    allParameters[@"timespan"] = str_timeItl;
    
    return allParameters;
}

/**
 根数据
 */
- (void)rootDataRequestWithSuccess:(void (^)())success
                           failure:(void (^)(NSString *message))failure {
    NSDictionary *parameters = @{
                                 @"qt" : @"rgc",
                                 @"dis_poi" : @"1",
                                 @"x" : @"13407612.87",
                                 @"y" : @"3550364.78"
                                 };
    [self.afNetworkingTool getRequestWithURLString:nil
                                         parameters:parameters
                                            success:^(id JSON) {
        LKXMLog(@"使用百度坐标拾取器接口:%@", JSON);
        success();
    } failure:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

@end
