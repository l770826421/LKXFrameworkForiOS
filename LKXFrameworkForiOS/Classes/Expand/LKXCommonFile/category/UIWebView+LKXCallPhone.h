//
//  UIWebView+LKXCallPhone.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/5/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (LKXCallPhone)

/**
 *  @author 刘克邪
 *
 *  @brief  拨打电话
 */
+ (instancetype)lkx_callPhone:(NSString *)phone;

@end
