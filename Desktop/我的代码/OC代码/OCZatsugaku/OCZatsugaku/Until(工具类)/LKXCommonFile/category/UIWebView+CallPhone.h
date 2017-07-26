//
//  UIWebView+CallPhone.h
//  SLShop
//
//  Created by lkx on 16/5/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (CallPhone)

/**
 *  @author 刘克邪
 *
 *  @brief  拨打电话
 */
+ (instancetype)callPhone:(NSString *)phone;

@end
