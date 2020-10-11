//
//  LKXWebViewController.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/29.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXScrollViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LKXAPPDefine.h"

@interface LKXWebViewController : LKXScrollViewController <UIWebViewDelegate>

/** webView */
@property (nonatomic, strong) UIWebView * _Nonnull webView;
/** 网页内部是否支持自动跳转 */
@property (nonatomic, assign, getter=isAutoRedirect) BOOL autoRedirect;

/** JSContext,JS and OC 交互 */
@property (nonatomic, strong) JSContext * _Nullable  context;

/** 展示的Url字符串 */
@property (nonatomic, copy) NSString * _Nullable  urlString;

/** post参数 */
@property (nonatomic, strong) NSMutableDictionary * _Nullable parameters;
/** 请求方式,默认是"GET" */
@property (nonatomic, assign) LKXWebViewHTTPMethod HTTPMethod;


- (void)startLoadWeb;

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView * _Nullable)webView shouldStartLoadWithRequest:(NSURLRequest * _Nullable)request navigationType:(UIWebViewNavigationType)navigationType;

- (void)webViewDidStartLoad:(UIWebView * _Nullable)webView;

- (void)webViewDidFinishLoad:(UIWebView * _Nullable)webView;

- (void)webView:(UIWebView * _Nullable)webView didFailLoadWithError:(nullable NSError *)error;

#pragma mark - other

/**
 *  @author 刘克邪
 *
 *  @brief  JS传回来的字符串值
 *
 */
- (nonnull NSString *)stringParameterWithContext;

/**
 *  @author 刘克邪
 *
 *  @brief  JS传回来的字典
 *
 */
- (nonnull NSDictionary *)dictionaryParameterWithContext;

/**
 *  @author 刘克邪
 *
 *  @brief  webView Post 的请求参数
 */
- (void)jionParameterWithDictionary:(nonnull NSDictionary *)dic;

@end
