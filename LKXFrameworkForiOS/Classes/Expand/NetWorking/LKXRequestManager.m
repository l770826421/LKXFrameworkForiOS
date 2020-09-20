//
//  LKXRequestManager.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXRequestManager.h"
#import "AFNetWorkingTool.h"

@interface LKXRequestManager ()

/** AFNetWorkingTool工具类 */
@property (nonatomic, strong) AFNetWorkingTool *afNetworkingTool;

@end

@implementation LKXRequestManager

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
    static LKXRequestManager *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)categoryWithURL:(NSString *)url success:(void (^)(NSDictionary *json))success failure:(void (^)(NSString *message))failure {
    [self.afNetworkingTool getRequestWithURLString:url showActivityIndicator:NO parameters:@{@"parent_id": @"0"} progress:nil dictionarySuccess:^(NSDictionary *json) {
        success(json);
    } failure:^(NSError *error) {
        failure(error.description);
    }];
}

@end
