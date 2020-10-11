//
//  LKXWKWebViewController.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/3/20.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXScrollViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "LKXAPPDefine.h"

@interface LKXWKWebViewController : LKXScrollViewController <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

/** WKWebView */
@property (nonatomic, strong) WKWebView * _Nonnull webView;
/** 是否支持网页内部跳转 */
@property (nonatomic, assign, getter=isAutoRedirect) BOOL autoRedirect;

/** 网址URL */
@property (nonatomic, copy) NSString * _Nonnull urlString;
/** 提交的参数 */
@property (nonatomic, strong) NSMutableDictionary * _Nonnull parameters;
/** 请求方式,默认是"GET" */
@property (nonatomic, assign) LKXWebViewHTTPMethod HTTPMethod;
/**
 js调用的oc方法数组
 */
@property (nonatomic, strong) NSArray <NSString *> * _Nonnull jsCallSelectors;

/**
 开始load网页
 */
- (void)startLoadWeb;

#pragma mark - WKNavigationDelegate
// 追踪加载过程
/**
 页面开始加载调用
 */
- (void)webView:(WKWebView * _Nonnull)webView didStartProvisionalNavigation:(WKNavigation * _Nonnull)navigation;

/**
 当内容开始返回时调用
 */
- (void)webView:(WKWebView * _Nonnull)webView didCommitNavigation:(WKNavigation * _Nonnull)navigation;

/**
 页面加载完成之后调用
 */
- (void)webView:(WKWebView * _Nonnull)webView didFinishNavigation:(WKNavigation * _Nonnull)navigation;

/**
 页面加载失败调用
 */
- (void)webView:(WKWebView * _Nonnull)webView didFailNavigation:(WKNavigation * _Nonnull)navigation withError:(NSError * _Nonnull)error;

// 页面跳转

/**
 接收到服务器跳转请求之后再执行
 */
- (void)webView:(WKWebView * _Nonnull)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation * _Nonnull)navigation;

/**
 在发送请求之前,决定是否跳转
 */
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationAction:(WKNavigationAction * _Nonnull)navigationAction decisionHandler:(void (^ _Nonnull)(WKNavigationActionPolicy))decisionHandler ;


/**
 接收到响应后,决定是否跳转
 */
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationResponse:(WKNavigationResponse * _Nonnull)navigationResponse decisionHandler:(void (^ _Nonnull)(WKNavigationResponsePolicy))decisionHandler;

#pragma mark - WKUIDelegate

/**
 创建一个新的webView
 */
- (WKWebView * _Nonnull)webView:(WKWebView * _Nonnull)webView createWebViewWithConfiguration:(WKWebViewConfiguration * _Nonnull)configuration forNavigationAction:(WKNavigationAction * _Nonnull)navigationAction windowFeatures:(WKWindowFeatures * _Nonnull)windowFeatures;

/**
 webView关闭 9.0新方法
 */
- (void)webViewDidClose:(WKWebView * _Nonnull)webView;

/**
 显示一个JS的Alert(与JS交互)
 */
- (void)webView:(WKWebView * _Nonnull)webView runJavaScriptAlertPanelWithMessage:(NSString * _Nonnull)message initiatedByFrame:(WKFrameInfo * _Nonnull)frame completionHandler:(void (^ _Nonnull)(void))completionHandler;

/**
 弹出一个输入框(与JS交互的)
 */
- (void)webView:(WKWebView * _Nonnull)webView runJavaScriptTextInputPanelWithPrompt:(NSString * _Nonnull)prompt defaultText:(NSString * _Nullable)defaultText initiatedByFrame:(WKFrameInfo * _Nonnull)frame completionHandler:(void (^ _Nonnull)(NSString * _Nullable))completionHandler;

/**
 显示一个确认框(JS的)
 */
- (void)webView:(WKWebView * _Nonnull)webView runJavaScriptConfirmPanelWithMessage:(NSString * _Nullable)message initiatedByFrame:(WKFrameInfo * _Nonnull)frame completionHandler:(void (^ _Nonnull)(BOOL))completionHandler;

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController * _Nullable)userContentController didReceiveScriptMessage:(WKScriptMessage * _Nullable)message;

@end
