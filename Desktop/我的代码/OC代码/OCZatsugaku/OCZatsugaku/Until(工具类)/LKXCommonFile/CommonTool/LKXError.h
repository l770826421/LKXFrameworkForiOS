//
//  LKXError.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/8/1.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author 刘克邪
 *
 *  @brief  在需要自定义错误信息的时候就可以使用这个类了
 */
@interface LKXError : NSError

/**
 *  @author 刘克邪
 *
 *  @brief  初始化错误对象
 *
 */
+ (instancetype)lkx_error;

/**
 *  @author 刘克邪
 *
 *  @brief  自定义设置错误信息
 *
 */
- (void)lkx_setUserInfo:(NSString *)info;

@end
