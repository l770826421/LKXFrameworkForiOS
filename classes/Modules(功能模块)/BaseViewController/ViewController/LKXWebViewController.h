//
//  LKXWebViewController.h
//  XGMEport
//
//  Created by lkx on 16/3/29.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXBaseViewController.h"

@interface LKXWebViewController : LKXBaseViewController <UIWebViewDelegate>

/** webView */
@property (nonatomic, strong) UIWebView *webView;

/** 展示的Url字符串 */
@property (nonatomic, copy) NSString *urlString;

@end
