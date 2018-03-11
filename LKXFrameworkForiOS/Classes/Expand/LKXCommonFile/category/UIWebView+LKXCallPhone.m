//
//  UIWebView+LKXCallPhone.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/5/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "UIWebView+LKXCallPhone.h"

@implementation UIWebView (LKXCallPhone)

/**
 *  @author 刘克邪
 *
 *  @brief  拨打电话
 */
+ (instancetype)lkx_callPhone:(NSString *)phone {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", phone];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    return callWebview;
}

@end
