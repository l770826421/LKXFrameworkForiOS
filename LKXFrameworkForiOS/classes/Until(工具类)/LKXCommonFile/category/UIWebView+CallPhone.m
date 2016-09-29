//
//  UIWebView+CallPhone.m
//  SLShop
//
//  Created by lkx on 16/5/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "UIWebView+CallPhone.h"

@implementation UIWebView (CallPhone)

/**
 *  @author 刘克邪
 *
 *  @brief  拨打电话
 */
+ (instancetype)callPhone:(NSString *)phone {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", phone];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    return callWebview;
}

@end
