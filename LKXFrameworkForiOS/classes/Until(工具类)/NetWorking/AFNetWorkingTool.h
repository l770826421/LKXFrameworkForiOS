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
#define kAPPBaseUrl @"http://magicers1992.6655.la:30974/yikatong/cardPass.php"
#else
#define kAPPBaseUrl @"http://60.29.211.84:8018/yikatong/cardPass.php" 
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
 *  @param parameters       请求子路径
 *  @param success    success Block
 *  @param failure    failure Block
 */
- (void)getRequestWithParameters:(NSDictionary *)parameters success:(AFNetWorkingToolSuccessBlock)success failure:(AFNetWorkingToolFailureBlock)failure;

/**
 *  @author 刘克邪
 *
 *  @brief  POST请求
 *
 */
- (void)postRequestWithParameters:(NSDictionary *)parameters success:(AFNetWorkingToolSuccessBlock)success failure:(AFNetWorkingToolFailureBlock)failure;

@end
