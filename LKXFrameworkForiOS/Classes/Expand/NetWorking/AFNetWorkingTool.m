//
//  AFNetWorkingTool.m
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "AFNetWorkingTool.h"
#import "LKXError.h"

#define kTimeoutIntervalForRequest 30

@interface AFNetWorkingTool ()

/** 数据请求对象 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
/** URL请求对象 */
@property(nonatomic, strong) AFURLSessionManager *urlSessionManager;

@end

@implementation AFNetWorkingTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static AFNetWorkingTool *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        
        // 可以标识请求,请求超时时间
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = kTimeoutIntervalForRequest;
        
        // baseURl
        NSURL *baseUrl = [NSURL URLWithString:kAPPBaseUrl];
        instance.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl sessionConfiguration:configuration];
        instance.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        instance.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json",
                           @"application/xml", @"text/json",
                           @"text/javascript", nil];
        instance.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        instance.sessionManager.requestSerializer.timeoutInterval =  kTimeoutIntervalForRequest;
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
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
    return [[AFNetWorkingTool alloc] init];
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
        [kMBHUDTool showActivityIndicatorWithText:nil detailText:nil];
    }
    [self.sessionManager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
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
        [kMBHUDTool showActivityIndicatorWithText:nil detailText:nil];
    }
    
    [self.sessionManager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
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
    int code = [dic[@"status"] intValue];;
    if (code) {
        return NO;
    } else {
        return YES;
    }
}

@end