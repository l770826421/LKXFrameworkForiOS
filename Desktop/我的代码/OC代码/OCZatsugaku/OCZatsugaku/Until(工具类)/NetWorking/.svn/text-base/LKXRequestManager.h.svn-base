//
//  LKXRequestManager.h
//  XGMEport
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestManagerSuccessBlock)(id obj);
typedef void (^RequestManagerFailureBlock)(NSString *errorInfo);

/**
 *  @author 刘克邪
 *
 *  @brief  随行实际对应的请求类
 */
@interface LKXRequestManager : NSObject

/**
 *  @author 刘克邪
 *
 *  @brief  每一个单例必须以share开头
 *
 */
+ (instancetype)shareRequestManager;

/**
 根数据
 */
- (void)rootDataRequestWithSuccess:(void (^)())success
                           failure:(void (^)(NSString *message))failure;

@end
