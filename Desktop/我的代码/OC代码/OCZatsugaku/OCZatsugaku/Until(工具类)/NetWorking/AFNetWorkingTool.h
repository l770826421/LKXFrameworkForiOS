//
//  AFNetWorkingTool.h
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

//#define isOnLine 0

#ifdef isOnLine 
#define kAPPBaseUrl @"http://api.map.baidu.com"
#else
#define kAPPBaseUrl @"http://api.map.baidu.com"
#endif

typedef void (^AFNetWorkingToolSuccessBlock)(id JSON);
typedef void (^AFNetWorkingToolFailureBlock)(NSError *error);

/**
 *  @author 刘克邪
 *
 *  @brief  AFNetWorking的请求封装类
 */
@interface AFNetWorkingTool : NSObject

/**
 *  @author 刘克邪
 *
 *  @brief  AFNetWorkingTool单例
 *
 */
+ (instancetype)shareAFNetWorkingTool;

/**
 *  @author 刘克邪
 *
 *  @brief  GET请求
 *
 *  @param urlString       请求路径
 *  @param parameters      请求参数
 *  @param success    success Block
 *  @param failure    failure Block
 */
- (void)getRequestWithURLString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
                        success:(AFNetWorkingToolSuccessBlock)success
                        failure:(AFNetWorkingToolFailureBlock)failure;

/**
 *  @author 刘克邪
 *
 *  @brief  POST请求
 *
 *  @param urlString       请求路径
 *  @param parameters      请求参数
 *  @param success    success Block
 *  @param failure    failure Block
 */
- (void)postRequestWithURLString:(NSString *)urlString
                      parameters:(NSDictionary *)parameters
                         success:(AFNetWorkingToolSuccessBlock)success
                         failure:(AFNetWorkingToolFailureBlock)failure;

@end
