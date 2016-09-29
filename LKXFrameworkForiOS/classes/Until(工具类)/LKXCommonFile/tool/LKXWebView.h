//
//  LKXWebView.h
//  MyCategory
//
//  Created by lkx on 14-11-28.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKXWebView : UIWebView <UIWebViewDelegate>

@property (nonatomic, copy) void (^ReturnWebInfoBlock)(NSString *info);

@end
