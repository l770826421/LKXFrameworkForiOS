//
//  LKXWebViewController.m
//  XGMEport
//
//  Created by lkx on 16/3/29.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXWebViewController.h"
#import "LKXLayoutContraint.h"

@interface LKXWebViewController ()

@end

@implementation LKXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    [self.view addConstraints:[NSLayoutConstraint lkx_constraintsWithItem:self.webView]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter and setter
- (UIWebView *)webView {
    
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.delegate = self;
    }
    
    return _webView;
}

@end
