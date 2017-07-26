//
//  AFNetWorkingTool.m
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "AFNetWorkingTool.h"
#import "LKXError.h"

#define kTimeoutIntervalForRequest 60

@interface AFNetWorkingTool ()

/** 数据请求对象 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation AFNetWorkingTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static AFNetWorkingTool *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        
        // 可以标识请求,请求超时时间
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        configuration.timeoutIntervalForRequest = kTimeoutIntervalForRequest;
        
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

/**
 *  @author 刘克邪
 *
 *  @brief  GET请求
 *
 *  @param parameters       请求子路径
 *  @param success    success Block
 *  @param failure    failure Block
 */
- (void)getRequestWithParameters:(NSDictionary *)parameters
                         success:(AFNetWorkingToolSuccessBlock)success
                         failure:(AFNetWorkingToolFailureBlock)failure {
    
    [[MBHUDTool sharedMBHUDTool] showActivityIndicator];
    [self.sessionManager GET:@"" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BOOL succ = [self dataSeparteWithCode:responseObject];
        if (succ) { // 获取到成功的数据
            success(responseObject[@"data"]);
        } else { // 获取到失败的信息
            LKXError *err = [LKXError lkx_error];
            [err lkx_setUserInfo:responseObject[@"info"]];
            failure(err);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LKXError *err = [LKXError lkx_error];
        if (Dev_IOSVersion < 10.0) {
            [err lkx_setUserInfo:@"网络已断开,请检查网络是否连接。"];
        } else {
            [err lkx_setUserInfo:@"网络已断开,请检查网络设置，设置>蜂窝移动网络>使用无线局域网与蜂窝移动的应用。"];
        }
        
        failure(err);
    }];
}

/**
 *  @author 刘克邪
 *
 *  @brief  POST请求
 *
 */
- (void)postRequestWithParameters:(NSDictionary *)parameters
                          success:(AFNetWorkingToolSuccessBlock)success
                          failure:(AFNetWorkingToolFailureBlock)failure {
    
    [[MBHUDTool sharedMBHUDTool] showActivityIndicator];
    [self.sessionManager POST:@"" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LKXMLog(@"%@", task.currentRequest.URL);
        NSDictionary *json = [self dictionaryForData:responseObject];
        if (json == nil) {
            LKXError *err = [LKXError lkx_error];
            [err lkx_setUserInfo:@"返回数据为空"];
            return ;
        }
        
        BOOL succ = [self dataSeparteWithCode:json];
        if (succ) { // 获取到成功的数据
            success(json[@"data"]);
        } else { // 获取到失败的信息
            failure(json[@"info"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LKXError *err = [LKXError lkx_error];
        if (Dev_IOSVersion < 10.0) {
            [err lkx_setUserInfo:@"网络已断开,请检查网络是否连接。"];
        } else {
            [err lkx_setUserInfo:@"网络已断开,请检查网络设置，设置>蜂窝移动网络>使用无线局域网与蜂窝移动的应用。"];
        }
        
        failure(err);
    }];
}

- (NSDictionary *)dictionaryForData:(NSData *)data {
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSString *src = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        LKXMLog(@"非json数据 = %@", src);
        return nil;
    } else {
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
