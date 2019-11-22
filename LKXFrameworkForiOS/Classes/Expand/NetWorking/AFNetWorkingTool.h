//
//  AFNetWorkingTool.h
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^AFNetWorkingToolJSONSuccessBlock)(NSDictionary * _Nullable json);
typedef void (^AFNetWorkingToolStringSuccessBlock)(NSString * _Nonnull string);
typedef void (^AFNetWorkingToolDataSuccessBlock)(NSData * _Nonnull data);
typedef void (^AFNetWorkingToolProgressBlock)(CGFloat totalProgress, CGFloat completedProgress);
typedef void (^AFNetWorkingToolFailureBlock)(NSError * _Nonnull error);

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
+ (instancetype _Nullable )shareAFNetWorkingTool;

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
- (void)getRequestWithURLString:(NSString *_Nonnull)urlString
          showActivityIndicator:(BOOL)show
                     parameters:(NSDictionary *_Nullable)parameters
                       progress:(AFNetWorkingToolProgressBlock _Nonnull )progress
              dictionarySuccess:(AFNetWorkingToolJSONSuccessBlock _Nonnull )dicSuccess
                        failure:(AFNetWorkingToolFailureBlock _Nonnull )failure;

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

#pragma mark - 下载文件

/// 下载文件
/// @param urlString 下载链接
/// @param HTTPMethod 请求方式
/// @param show 是否显示小菊花
/// @param parameters 请求参数
/// @param progress 进度
/// @param saveAsDestinatiomCompletion 将缓存文件另存到指定位置,targetPath->在tmp下缓存路径, 会在下载完后删除),fileName->文件名
/// @param success 请求结果, 文件保存路劲, 文件名
/// @param failure 请求失败
- (void)downloadRequestWithURL:(NSString *)urlString
                    HTTPMethod:(NSString *)HTTPMethod
         showActivityIndicator:(BOOL)show
                    parameters:(NSDictionary *)parameters
                      progress:(AFNetWorkingToolProgressBlock)progress
     saveTempFileToDestination:(NSURL *(^)(NSURL *targetPath, NSString *fileName))saveAsDestinatiomCompletion
                       success:(void(^)(NSURL *url, NSString  *filename))success
                       failure:(AFNetWorkingToolFailureBlock)failure;

/**
 上傳文件
 
 @param urlString 上傳路勁
 @param show 是否显示小菊花
 @param fileDatas 文件Data
 @param parameters 上傳參數
 @param appendFileDataCompletion 拼接上传的数据流
 @param success 請求成功block
 @param failure 請求失敗block
 */
- (void)uploadWithURLString:(NSString *)urlString
      showActivityIndicator:(BOOL)show
                  fileDatas:(NSArray *)fileDatas
                 parameters:(NSDictionary *)parameters
             appendFileData:(id<AFMultipartFormData> _Nonnull (^_Nonnull)(id<AFMultipartFormData>  _Nonnull formData))appendFileDataCompletion
                    success:(AFNetWorkingToolJSONSuccessBlock _Nonnull )success
                    failure:(AFNetWorkingToolFailureBlock _Nonnull )failure;

@end

NS_ASSUME_NONNULL_END
