//
//  LKXWigetViewController.m
//  LKXWiget
//
//  Created by lkx on 2016/11/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXWigetViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface LKXWigetViewController () <NCWidgetProviding>

@end

@implementation LKXWigetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置widget展示视图的大小
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
