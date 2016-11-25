//
//  LKXWKWebViewController.m
//  XGMEport
//
//  Created by lkx on 16/3/29.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXWKWebViewController.h"
#import "Masonry.h"

#define kVSID @"651-1-1478585901990"

@interface LKXWKWebViewController ()
{
    NSMutableURLRequest *_request;
}

@end

@implementation LKXWKWebViewController

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
//    [self.view addConstraints:[NSLayoutConstraint lkx_constraintsWithItem:self.webView]];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self addHeaderInScrollView:self.webView.scrollView];
    self.webView.scrollView.bounces = YES;
    
    // https://www.baidu.com
    self.urlString = @"http://wsg.tjgportnet.com:8000/Index.aspx?func=&vsid=651-1-1478588609268";
    [self startLoadWeb];
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
    [self.parameters setValue:kVSID forKey:@"vsid"];
    
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

- (NSString *)readCurrenCookie {
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableString *cookieSrc = [NSMutableString string];
    for (NSHTTPCookie *cookie in [myCookie cookies]) {
        LKXMLog(@"%@", cookie);
        [cookieSrc appendFormat:@"%@=%@;", cookie.name, cookie.value];
    }
    return cookieSrc;
}

- (void)startLoadWeb {
    
    if ([NSString isEmptyWithString:self.urlString]) {
        [kMBHUDTool showHUDWithText:@"没有填充URL" delay:kMBHUDDelay];
        LKXMLog(@"没有填充URL");
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
//    NSString *customUserAgent = @"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; .NET4.0E; Media Center PC 6.0; McAfee)";
//    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":customUserAgent}];
    _request = [NSMutableURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:10.f];
//    _request = [[NSMutableURLRequest alloc] initWithURL:url];
    [_request setHTTPMethod:@"GET"];
//    [_request setValue:@"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; .NET4.0E; Media Center PC 6.0; McAfee)" forHTTPHeaderField:@"User-Agent"];
//    [_request setValue:@"*//*" forHTTPHeaderField:@"Accept"];
    
//    NSString *cookieSrc = [self readCurrenCookie];
//    if (![NSString isEmptyWithString:cookieSrc]) {
//        [request addValue:cookieSrc forHTTPHeaderField:@"Cookie"];
//    }
//    NSString *body = [self bodyParameters];
//    if (![NSString isEmptyWithString:body]) {
//        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
    [self.webView loadRequest:_request];
    
    [[MBHUDTool sharedMBHUDTool] showActivityIndicator];
}

#pragma mark - getter and setter
- (WKWebView *)webView {
    
    if (!_webView ) {
//        NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        NSMutableString *source = [NSMutableString string];
//        for (NSHTTPCookie *cookie in [myCookie cookies]) {
//            LKXMLog(@"%@", cookie);
//            [source appendFormat:@"document.cookie = '%@=%@';", cookie.name, cookie.value];
//        }
//        
//        WKUserContentController* userContentController = [[WKUserContentController alloc] init];;
//        WKUserScript * cookieScript = [[WKUserScript alloc]
//                                       initWithSource:source
//                                       injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
//        [userContentController addUserScript:cookieScript];
//        
//        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//        configuration.preferences.javaScriptEnabled = YES;
//        configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
//        configuration.userContentController = userContentController;
//        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces  = NO;
        _webView.scrollView.delegate = self;
        _webView.scrollView.backgroundColor = self.view.backgroundColor;
    }
    
    return _webView;
}

- (JSContext *)context {
    if (_context == nil) {
        _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}

#pragma mark - WKNavigationDelegate

/**
 在发送请求之前,决定是否跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    LKXMLog(@"在发送请求之前,决定是否跳转--%@", decisionHandler);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


/**
 在收到响应后,决定是否跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}


/**
 页面开始加载时调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    LKXMLog(@"页面开始加载时调用");
}


/**
 接收到服务器请求之后跳转
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    LKXMLog(@"接收到服务器请求之后跳转");
}


/**
 页面加载失败调用
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    LKXMLog(@"页面加载失败调用:%@", error);
}


/**
 当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    LKXMLog(@"当内容开始返回时调用");
}


/**
 页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [kMBHUDTool hideMBHUD:YES];
    [webView.scrollView.mj_header endRefreshing];
}


- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    LKXMLog(@"didFailNavigation:%@", error);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    LKXMLog(@"webViewWebContentProcessDidTerminate");
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    LKXMLog(@"createWebViewWithConfiguration:%@", configuration);
    return webView;
}

- (void)webViewDidClose:(WKWebView *)webView {
    LKXMLog(@"webViewDidClose");
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    completionHandler();
    LKXMLog(@"runJavaScriptAlertPanelWithMessage");
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    LKXMLog(@"runJavaScriptConfirmPanelWithMessage");
    completionHandler(YES);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler; {
    LKXMLog(@"runJavaScriptTextInputPanelWithPrompt");
}

//- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
//    LKXMLog(@"shouldPreviewElement:%@", elementInfo);
//}
//
//- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions {
//    LKXMLog(@"previewingViewControllerForElement:%@--previewingViewControllerForElement:%@", elementInfo, previewActions);
//}

- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
    LKXMLog(@"commitPreviewingViewController");
}

#pragma mark - UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
////    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//     NSString *requestString = [[[request URL] absoluteString] stringByRemovingPercentEncoding];
//    
//    if (self.isAutoRedirect) {
//        return YES;
//    } /*else if (![requestString hasPrefix:self.urlString]) {
//        return NO;
//    }*/
//    LKXMLog(@"%@", requestString);
//    
//    return YES;
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    LKXMLog(@"webViewDidStartLoad");
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//
//    [[MBHUDTool sharedMBHUDTool] hideMBHUD:YES];
//    //禁止长按打开某东西
////    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
////    NSString *downRefresh = @"javascript:(function(){$(window).scroll(function(){"
////    "if($(document).height()-$(document).scrollTop()-$(window).height() < 20){"
////    "var hasData = $(this).attr('hasData');"
////    "showMsgWithDownRefresh(hasData);}});})()";
////    [webView stringByEvaluatingJavaScriptFromString:downRefresh];
//    
//    [webView.scrollView.mj_header endRefreshing];
//    LKXMLog(@"webViewDidFinishLoad");
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
//    LKXMLog(@"didFailLoadWithError , error = %@", error.description);
//    [webView.scrollView.mj_header endRefreshing];
//    [[MBHUDTool sharedMBHUDTool] hideMBHUD:YES];
//}

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
    
    self.parameters = [parameters mutableCopy];;
}

@end
