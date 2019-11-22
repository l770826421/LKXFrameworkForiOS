//
//  LKXRequestManager.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

- (void)categoryWithURL:(NSString *)url success:(void (^)(NSDictionary *json))success failure:(void (^)(NSString *message))failure;

@end

NS_ASSUME_NONNULL_END
