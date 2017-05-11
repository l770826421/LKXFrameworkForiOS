//
//  LKXWKWebViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/3/20.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXWKWebViewController.h"
#import "Masonry.h"

@interface LKXWKWebViewController ()

@end

@implementation LKXWKWebViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.autoRedirect = YES;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

/**
 开始load网页
 */
- (void)startLoadWeb {
    
    NSAssert(![NSString isEmptyWithString:self.urlString], @"没有传入网址URL");
    
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
- (WKWebView *)webView {
    
    if (!_webView ) {
        _webView = [[WKWebView alloc] init];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
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
// 追踪加载过程
/**
 页面开始加载调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    LKXMLog(@"接收到服务器请求之后跳转");
}

/**
 当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    LKXMLog(@"当内容开始返回时调用");
}

/**
 页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [kMBHUDTool hideMBHUD:YES];
    if (self.webView.scrollView.mj_header.isRefreshing) {
        [self.webView.scrollView.mj_header endRefreshing];
    }
}

/**
 页面加载失败调用
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    LKXMLog(@"页面加载失败%@", error);
}

// 页面跳转

/**
 接收到服务器跳转请求之后再执行
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

/**
 在发送请求之前,决定是否跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    LKXMLog(@"在发送请求之前,决定是否跳转--%@", decisionHandler);
    WKNavigationActionPolicy policy = _autoRedirect ? WKNavigationActionPolicyAllow : WKNavigationActionPolicyCancel;
    decisionHandler(policy);
}


/**
 接收到响应后,决定是否跳转
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    WKNavigationResponsePolicy policy = _autoRedirect ? WKNavigationResponsePolicyAllow : WKNavigationResponsePolicyCancel;
    decisionHandler(policy);
}

#pragma mark - WKUIDelegate

/**
 创建一个新的webView
 */
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    return webView;
}

/**
 webView关闭 9.0新方法
 */
- (void)webViewDidClose:(WKWebView *)webView {
    
}

/**
 显示一个JS的Alert(与JS交互)
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}

/**
 弹出一个输入框(与JS交互的)
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
}

/**
 显示一个确认框(JS的)
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
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
 *  @brief  webView 请求参数
 */
- (void)jionParameterWithDictionary:(NSDictionary *)dic {
    
    if (!dic) {
        dic = @{};
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    self.parameters = [parameters mutableCopy];
}

@end
