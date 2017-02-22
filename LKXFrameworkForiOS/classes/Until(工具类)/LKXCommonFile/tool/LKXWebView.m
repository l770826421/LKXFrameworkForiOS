//
//  LKXWebView.m
//  MyCategory
//
//  Created by lkx on 14-11-28.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "LKXWebView.h"

@implementation LKXWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
    }   
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [request.URL absoluteString].stringByRemovingPercentEncoding; //stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([requestString hasPrefix:@""])
    {
        //返回产品
        NSString *goodId = [[requestString componentsSeparatedByString:@"="] lastObject];
        if (self.ReturnWebInfoBlock)
        {
            self.ReturnWebInfoBlock(goodId);
        }
        return NO;
    }
//    else if ([requestString hasPrefix:@"http://"])
//    {
//        //返回URL
//        if (self.ReturnWebInfoBlock)
//        {
//            self.ReturnWebInfoBlock(requestString);
//        }
////        return YES;
//    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    LKXNLog(@"开始下载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    LKXNLog(@"结束下载");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    LKXNLog(@"错误error == %@", error.description);
}

@end
