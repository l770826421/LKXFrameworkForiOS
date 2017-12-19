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

typedef void (^AFNetWorkingToolJSONSuccessBlock)(NSDictionary *json);
typedef void (^AFNetWorkingToolStringSuccessBlock)(NSString *string);
typedef void (^AFNetWorkingToolDataSuccessBlock)(NSData *data);
typedef void (^AFNetWorkingToolProgressBlock)(CGFloat totalProgress, CGFloat completedProgress);
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

#pragma mark - get请求

/**
 get请求
 
 @param urlString 请求URL
 @param show 是否显示小菊花
 @param parameters 请求参数
 @param progress 请求进度
 @param dicSuccess 请求结果是NSDictionary
 @param failure 请求失败
 */
- (void)getRequestWithURLString:(NSString *)urlString
          showActivityIndicator:(BOOL)show
                     parameters:(NSDictionary *)parameters
                       progress:(AFNetWorkingToolProgressBlock)progress
              dictionarySuccess:(AFNetWorkingToolJSONSuccessBlock)dicSuccess
                        failure:(AFNetWorkingToolFailureBlock)failure;

/**
 get请求
 
 @param urlString 请求URL
 @param show 是否显示小菊花
 @param parameters 请求参数
 @param progress 请求进度
 @param stringSuccess 请求结果是NSString
 @param failure 请求失败
 */
- (void)getRequestWithURLString:(NSString *)urlString
          showActivityIndicator:(BOOL)show
                     parameters:(NSDictionary *)parameters
                       progress:(AFNetWorkingToolProgressBlock)progress
                  stringSuccess:(AFNetWorkingToolStringSuccessBlock)stringSuccess
                        failure:(AFNetWorkingToolFailureBlock)failure;

/**
 get请求
 
 @param urlString 请求URL
 @param show 是否显示小菊花
 @param parameters 请求参数
 @param progress 请求进度
 @param dataSuccess 请求结果是NSData
 @param failure 请求失败
 */
- (void)getRequestWithURLString:(NSString *)urlString
          showActivityIndicator:(BOOL)show
                     parameters:(NSDictionary *)parameters
                       progress:(AFNetWorkingToolProgressBlock)progress
                    dataSuccess:(AFNetWorkingToolDataSuccessBlock)dataSuccess
                        failure:(AFNetWorkingToolFailureBlock)failure;

#pragma mark - post请求
/**
 post请求
 
 @param urlString 请求URL字符串
 @param show 是否显示小菊花
 @param parameters 请求参数
 @param progress 请求进度
 @param dicSuccess 请求结果是NSDictionary
 @param failure 请求失败
 */
- (void)postRequestWithURL:(NSString *)urlString
     showActivityIndicator:(BOOL)show
                parameters:(NSDictionary *)parameters
                  progress:(AFNetWorkingToolProgressBlock)progress
         dictionarySuccess:(AFNetWorkingToolJSONSuccessBlock)dicSuccess
                   failure:(AFNetWorkingToolFailureBlock)failure;

/**
 post请求
 
 @param urlString 请求URL字符串
 @param show 是否显示小菊花
 @param parameters 请求参数
 @param progress 请求进度
 @param stringSuccess 请求结果是NSString
 @param failure 请求失败
 */
- (void)postRequestWithURL:(NSString *)urlString
     showActivityIndicator:(BOOL)show
                parameters:(NSDictionary *)parameters
                  progress:(AFNetWorkingToolProgressBlock)progress
             stringSuccess:(AFNetWorkingToolStringSuccessBlock)stringSuccess
                   failure:(AFNetWorkingToolFailureBlock)failure;
/**
 post请求
 
 @param urlString 请求URL
 @param show 是否显示小菊花
 @param parameters 请求参数
 @param progress 请求进度
 @param dataSuccess 请求结果是NSData
 @param failure 请求失败
 */
- (void)postRequestWithURL:(NSString *)urlString
     showActivityIndicator:(BOOL)show
                parameters:(NSDictionary *)parameters
                  progress:(AFNetWorkingToolProgressBlock)progress
               dataSuccess:(AFNetWorkingToolDataSuccessBlock)dataSuccess
                   failure:(AFNetWorkingToolFailureBlock)failure;


@end
