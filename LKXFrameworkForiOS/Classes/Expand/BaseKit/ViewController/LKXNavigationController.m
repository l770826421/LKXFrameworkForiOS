//
//  LKXNavigationController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXNavigationController.h"
#import "Macros_UICommon.h"

#define kNavigationBarBackgroundColor kAPPMainColor
#define kNavigationBarButtonItemFontColor [UIColor whiteColor]
#define kNavigationBarTitleColor [UIColor whiteColor]
#define kNavigationBarTitleboldFontSize 20

@interface LKXNavigationController ()

@end

@implementation LKXNavigationController

/**
 *  @author 刘克邪
 *
 *  @brief  一次设置导航栏的基本样式
 */
+ (void)initialize {
    // 导航栏北京颜色
    [[UINavigationBar appearance] setBarTintColor:kNavigationBarBackgroundColor];
    // 透明
    [UINavigationBar appearance].translucent = NO;
    
    // 导航栏title字体大小和颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kNavigationBarTitleColor, NSFontAttributeName :[UIFont boldSystemFontOfSize:kNavigationBarTitleboldFontSize]}];
    
    // 导航栏ButtonItem字体颜色
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kNavigationBarButtonItemFontColor} forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置一个NavigationBar背景图片
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 消除阴影
//    self.navigationBar.shadowImage = [UIImage new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 不是根控制器才需要隐藏UITabbar
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


@end
