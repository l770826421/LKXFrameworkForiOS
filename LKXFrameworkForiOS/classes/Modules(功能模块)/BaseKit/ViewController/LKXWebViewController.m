//
//  LKXWebViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/29.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXWebViewController.h"
//#import "LKXLayoutContraint.h"
#import "Masonry.h"

@interface LKXWebViewController ()

@end

@implementation LKXWebViewController

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self addHeaderInScrollView:self.webView.scrollView];
    self.webView.scrollView.bounces = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downRefreshData {
    [self startLoadWeb];
}

- (NSMutableDictionary *)parameters {
    
    if (!_parameters) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return _parameters;
}

- (NSString *)bodyParameters {
    
    NSMutableString *parameterStr = [NSMutableString string];
    NSArray *keys = [self.parameters allKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        [parameterStr appendFormat:@"%@=%@", key, self.parameters[key]];
        if (i < keys.count - 1) {
            [parameterStr appendString:@"&"];
        }
    }
    
    return parameterStr;
}

- (void)startLoadWeb {
    
    if ([NSString isEmptyWithString:self.urlString]) {
        [kMBHUDTool showHUDWithText:@"没有填充URL" delay:kMBHUDDelay];
        LKXMLog(@"没有填充URL");
        return;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *HTTPMethod = @"GET";
    if (_HTTPMethod == LKXWebViewHTTPMethodPOST) {
        HTTPMethod = @"POST";
    }
    [request setHTTPMethod:HTTPMethod];
    NSString *body = [self bodyParameters];
    if (![NSString isEmptyWithString:body]) {
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [self.webView loadRequest:request];
    
    [[MBHUDTool sharedMBHUDTool] showActivityIndicator];
}

#pragma mark - getter and setter
- (UIWebView *)webView {
    
    if (!_webView ) {
        _webView = [[UIWebView alloc] init];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.delegate = self;
        _webView.scalesPageToFit     = YES;
        _webView.scrollView.bounces  = NO;
        _webView.scrollView.delegate = self;
        _webView.scrollView.backgroundColor = self.view.backgroundColor;
        _webView.dataDetectorTypes   = UIDataDetectorTypeLink;
        _webView.allowsInlineMediaPlayback = YES;
        _webView.suppressesIncrementalRendering = YES;
    }
    
    return _webView;
}

- (JSContext *)context {
    if (_context == nil) {
        _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSString *requestString = [[[request URL] absoluteString] stringByRemovingPercentEncoding];
    
    if (self.isAutoRedirect) {
        return YES;
    } /*else if (![requestString hasPrefix:self.urlString]) {
        return NO;
    }*/
    LKXMLog(@"%@", requestString);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    LKXMLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [[MBHUDTool sharedMBHUDTool] hideMBHUD:YES];
    //禁止长按打开某东西
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//    NSString *downRefresh = @"javascript:(function(){$(window).scroll(function(){"
//    "if($(document).height()-$(document).scrollTop()-$(window).height() < 20){"
//    "var hasData = $(this).attr('hasData');"
//    "showMsgWithDownRefresh(hasData);}});})()";
//    [webView stringByEvaluatingJavaScriptFromString:downRefresh];
    
    [webView.scrollView.mj_header endRefreshing];
    LKXMLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    LKXMLog(@"didFailLoadWithError , error = %@", error.description);
    [webView.scrollView.mj_header endRefreshing];
    [[MBHUDTool sharedMBHUDTool] hideMBHUD:YES];
}

#pragma mark - other
/**
 *  @author 刘克邪
 *
 *  @brief  JS传回来的字符串值
 *
 */
- (NSString *)stringParameterWithContext {
    NSArray *args = [JSContext currentArguments];
    if (args.count == 0) {
        return nil;
    }
    
    JSValue *value = [args objectAtIndex:0];
    NSString *string = [value toString];
    return string;
}

/**
 *  @author 刘克邪
 *
 *  @brief  JS传回来的字典
 *
 */
- (NSDictionary *)dictionaryParameterWithContext {
    NSArray *args = [JSContext currentArguments];
    if (args.count == 0) {
        return nil;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (JSValue *value in args) {
        
        NSString *string = [value toString];
        NSMutableDictionary *dict = [string dictionaryWithString];
        if (dict) {
            [dic setValuesForKeysWithDictionary:dict];
        }
    }
    
    return dic;
}

/**
 *  @author 刘克邪
 *
 *  @brief  webView Post 的请求参数
 */
- (void)jionParameterWithDictionary:(NSDictionary *)dic {
    
    if (!dic) {
        dic = @{};
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    self.parameters = [parameters mutableCopy];
}

@end
