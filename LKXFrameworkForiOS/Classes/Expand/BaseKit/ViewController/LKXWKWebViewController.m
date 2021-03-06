//
//  LKXWKWebViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/3/20.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXWKWebViewController.h"
#import "LKXWebProgressView.h"

#import <Masonry/Masonry.h>
#import "Macros_UICommon.h"

@interface LKXWKWebViewController ()

/**
 webView加载进度条
 */
@property (nonatomic, strong) LKXWebProgressView *webProgressView;

@end

@implementation LKXWKWebViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.autoRedirect = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                      context:nil];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
    
    NSAssert(![NSString lkx_isEmptyWithString:self.urlString], @"没有传入网址URL");
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *HTTPMethod = @"GET";
    if (_HTTPMethod == LKXWebViewHTTPMethodPOST) {
        HTTPMethod = @"POST";
    }
    [request setHTTPMethod:HTTPMethod];
    NSString *body = [self bodyParameters];
    if (![NSString lkx_isEmptyWithString:body]) {
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [self.webView loadRequest:request];
    
    [kMBHUDTool showActivityIndicatorWithText:nil detailText:nil];
}

#pragma mark - getter and setter
- (WKWebView *)webView {
    if (!_webView ) {
        // webVeiw的配置对象
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences.javaScriptEnabled = YES;
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        for (NSString *sel in self.jsCallSelectors) {
            [configuration.userContentController addScriptMessageHandler:self name:sel];
        }
        
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        webView.translatesAutoresizingMaskIntoConstraints = NO;
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        webView.scrollView.bounces  = NO;
        webView.scrollView.delegate = self;
        webView.scrollView.backgroundColor = self.view.backgroundColor;
        _webView = webView;
    }
    
    return _webView;
}

- (LKXWebProgressView *)webProgressView {
    if (!_webProgressView) {
        _webProgressView = [[LKXWebProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.lkx_width, 2)];
        _webProgressView.backgroundColor = [UIColor whiteColor];
        _webProgressView.progressColor = kAPPMainColor;
        [self.view addSubview:_webProgressView];
    }
    return _webProgressView;
}

#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        LKXMLog(@"webView加载进度:%f", self.webView.estimatedProgress);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.webProgressView.hidden = NO;
            self.webProgressView.progress = self.webView.estimatedProgress;
            if (self.webView.estimatedProgress >= 1.0f) {
                self.webProgressView.hidden = YES;
            }
        });
    }
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
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
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
    LKXMLog(@"WKFrameInfo = %@", frame);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

/**
 弹出一个输入框(与JS交互的)
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    LKXMLog(@"runJavaScriptTextInputPanelWithPrompt");
    completionHandler(@"http");
}

/**
 显示一个确认框(JS的)
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    LKXMLog(@"runJavaScriptConfirmPanelWithMessage");
    completionHandler(YES);

}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    LKXMLog(@"js交互信息: %@", message);
}

@end
