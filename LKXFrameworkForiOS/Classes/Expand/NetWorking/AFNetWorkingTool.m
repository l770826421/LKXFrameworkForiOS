//
//  AFNetWorkingTool.m
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "AFNetWorkingTool.h"
#import "LKXError.h"
#import "Macros_UICommon.h"
#import "LKXAPPDefine.h"

#define kTimeoutIntervalForRequest 30

@interface AFNetWorkingTool ()

/** 数据请求对象 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
/** URL请求对象 */
@property(nonatomic, strong) AFURLSessionManager *urlSessionManager;

@end

/// AFNetWorking封装
@implementation AFNetWorkingTool

- (instancetype)init {
    self = [super init];
    if (self) {
        // 可以标识请求,请求超时时间
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = kTimeoutIntervalForRequest;
        
        // baseURl
        NSURL *baseUrl = [NSURL URLWithString:kAPPBaseUrl];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl sessionConfiguration:configuration];
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json",
                           @"application/xml", @"text/json",
                           @"text/javascript", nil];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval =  kTimeoutIntervalForRequest;
    }
    return self;
}

/**
 *  @author 刘克邪
 *
 *  @brief  AFNetWorkingTool单例
 *
 */
+ (instancetype)shareAFNetWorkingTool {
    static AFNetWorkingTool *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

/**
 *  @author 刘克邪
 *
 *  @brief  拼接请求URL
 *
 *  @param path 请求路径
 *
 *  @return 完整的URL
 */
- (NSString *)requestURL:(NSString *)path {
    NSString *src = [NSString stringWithFormat:@"%@", kAPPBaseUrl];
    LKXMLog(@"request url = %@", src);
    return src;
}

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
                        failure:(AFNetWorkingToolFailureBlock)failure {
    
    [self getRequestWithURLString:urlString
            showActivityIndicator:show
                       parameters:parameters
                         progress:^(CGFloat totalProgress, CGFloat completedProgress) {
        if (progress) {
                progress(totalProgress, completedProgress);
        }
        
    } dataSuccess:^(NSData *data) {
        NSDictionary *json = [self dictionaryForData:data];
        if (json == nil) {
            LKXError *err = [LKXError lkx_error];
            [err lkx_setUserInfo:@"返回数据为空"];
            return ;
        }
        
        BOOL succ = [self dataSeparteWithCode:json];
        if (succ) { // 获取到成功的数据
            dicSuccess(json[@"data"]);
        } else { // 获取到失败的信息
            failure(json[@"info"]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                        failure:(AFNetWorkingToolFailureBlock)failure {
    
    [self getRequestWithURLString:urlString
            showActivityIndicator:show
                       parameters:parameters
                         progress:^(CGFloat totalProgress, CGFloat completedProgress) {
         if (progress) {
             progress(totalProgress, completedProgress);
         }
    }  dataSuccess:^(NSData *data) {
        NSString *src = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        stringSuccess(src);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 get请求
 
 @param urlString 请求URL
 @param show 是否显示小菊花
 @param parameters 请求参数
 @param progress 请求进度
 @param success 请求结果是NSData
 @param failure 请求失败
 */
- (void)getRequestWithURLString:(NSString *)urlString
          showActivityIndicator:(BOOL)show
                     parameters:(NSDictionary *)parameters
                       progress:(AFNetWorkingToolProgressBlock)progress
                    dataSuccess:(AFNetWorkingToolDataSuccessBlock)dataSuccess
                        failure:(AFNetWorkingToolFailureBlock)failure {
    
    if (show) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [kMBHUDTool showActivityIndicatorWithText:nil detailText:nil];
        });
    }
    [self.sessionManager GET:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress.totalUnitCount, downloadProgress.completedUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dataSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

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
                   failure:(AFNetWorkingToolFailureBlock)failure {
    [self postRequestWithURL:urlString showActivityIndicator:show parameters:parameters progress:^(CGFloat totalProgress, CGFloat completedProgress) {
        if (progress) {
            progress(totalProgress, completedProgress);
        }
    } dataSuccess:^(NSData *data) {
        NSDictionary *json = [self dictionaryForData:data];
        if (json == nil) {
            LKXError *err = [LKXError lkx_error];
            [err lkx_setUserInfo:@"返回数据为空"];
            return ;
        }
        
        BOOL succ = [self dataSeparteWithCode:json];
        if (succ) { // 获取到成功的数据
            dicSuccess(json[@"data"]);
        } else { // 获取到失败的信息
            failure(json[@"info"]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                   failure:(AFNetWorkingToolFailureBlock)failure {
    [self postRequestWithURL:urlString showActivityIndicator:show parameters:parameters progress:^(CGFloat totalProgress, CGFloat completedProgress) {
        if (progress) {
            progress(totalProgress, completedProgress);
        }
    } dataSuccess:^(NSData *data) {
        NSString *src = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        stringSuccess(src);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

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
                   failure:(AFNetWorkingToolFailureBlock)failure {
    if (show) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [kMBHUDTool showActivityIndicatorWithText:nil detailText:nil];
        });
    }
    
    [self.sessionManager POST:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.totalUnitCount, uploadProgress.completedUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LKXMLog(@"%@", task.currentRequest.URL);
        dataSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

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
                       failure:(AFNetWorkingToolFailureBlock)failure {
    if (show) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [kMBHUDTool showActivityIndicatorWithText:nil detailText:nil];
        });
    }
    
    if (HTTPMethod.length == 0 || HTTPMethod == nil) {
        HTTPMethod = @"POST";
    }
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:HTTPMethod
                                                                                  URLString:urlString
                                                                                 parameters:nil
                                                                                      error:nil];
    
    [[self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        LKXNLog(@"downloadProgress: %lld / %lld", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *destinationURL = saveAsDestinatiomCompletion(targetPath, response.suggestedFilename);
        return destinationURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            LKXMLog(@"response: %@", response);
            success(filePath, response.suggestedFilename);
        }
    }] resume];
}

#pragma mark - 上传
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
             appendFileData:(id<AFMultipartFormData> (^)(id<AFMultipartFormData>  _Nonnull formData))appendFileDataCompletion
                    success:(AFNetWorkingToolJSONSuccessBlock)success
                    failure:(AFNetWorkingToolFailureBlock)failure {
    [[self.sessionManager POST:urlString
                    parameters:parameters
                       headers:nil
     constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (appendFileDataCompletion) {
            formData = appendFileDataCompletion(formData);
        } else {
            LKXNLog(@"上传文件没有拼接文件NSData");
            return;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [self dictionaryForData:responseObject];
        if ([self dataSeparteWithCode:json]) {
            success(json);
        } else {
            NSError *error = [NSError errorWithDomain:NSPOSIXErrorDomain
                                                 code:-1
                                             userInfo:@{NSLocalizedDescriptionKey : @"上傳失敗"}];
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }] resume];
}

#pragma mark - 私有方法
/**
 NSData转NSDictionary
 */
- (NSDictionary *)dictionaryForData:(NSData *)data {
    NSError *err;
    NSString *src = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        LKXMLog(@"非json数据 = %@", src);
        return nil;
    } else {
        LKXMLog(@"json数据 =\n %@", src);
        return dic;
    }
}


/**
 *  @author 刘克邪
 *
 *  @brief  根据code来分离出需要的数据
 *
 *  @param dic 数据来源
 *
 *  @return code == 1 数据源; code == 0 错误信息
 */
- (BOOL)dataSeparteWithCode:(NSDictionary *)dic {
    int code = [dic[kAFNetworkingForSuccessKey] intValue];;
    if (code) {
        return NO;
    } else {
        return YES;
    }
}

@end
