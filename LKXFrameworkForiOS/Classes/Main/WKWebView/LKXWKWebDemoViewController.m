//
//  LKXWKWebDemoViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/5/11.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXWKWebDemoViewController.h"

#import "LKXUser.h"

@interface LKXWKWebDemoViewController ()

@end

@implementation LKXWKWebDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.urlString = @"https://www.baidu.com";
    self.autoRedirect = YES;
    [self startLoadWeb];
    
    JSContext *context = [[JSContext alloc] init];
    LKXUser *user = [[LKXUser alloc] init];
    // 暴露属性
    [user setAddress:@"泰和"];
    // 非暴露属性
    user.name = @"lkx";
    context[@"user"] = user;
    
    JSValue *nameVal = [context evaluateScript:@"user.name"];
    JSValue *addressVal = [context evaluateScript:@"user.address"];
    LKXMLog(@"name: %@", nameVal);
    LKXMLog(@"address: %@", addressVal);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
