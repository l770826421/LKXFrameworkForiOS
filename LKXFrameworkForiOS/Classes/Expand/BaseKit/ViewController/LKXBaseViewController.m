//
//  LKXBaseViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXBaseViewController.h"
#import "UIBarButtonItem+LKXCategory.h"
#import "LKXReloadView.h"

#import <MJRefresh/MJRefresh.h>
#import "Macros_UICommon.h"
#import "LKXAPPDefine.h"
#import "LKXBigButton.h"

NSString * const kAPPCurrentLogin = @"kAPPCurrentLogin";

@interface LKXBaseViewController () <LKXReloadViewDelegate, UIViewControllerRestoration>

@end

@implementation LKXBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    [self deleteSystemTabBarButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.restorationIdentifier = NSStringFromClass([self class]);
    self.restorationClass = [self class];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kAPPVCMainColor;
    
    if (Dev_IOSVersion >= 11.0) {   // iOS11以上系统右滑返回问题
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 Navigator bar 左功能键
 
 @param imageName 对应的图片
 */
- (void)leftBarButtonItemWithImageName:(NSString *)imageName {
    UIButton *leftSliderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftSliderBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftSliderBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftSliderBtn addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftSliderBtn];
}

/**
 *  @author 刘克邪
 *
 *  @brief  navigationBar leftItem 示例化
 *
 *  @param normalName   normal image name
 *  @param selectedName selected image name
 */
- (void)rightItemImageWithNormalName:(NSString *)normalName selectedName:(NSString *)selectedName {
    self.navigationItem.rightBarButtonItem =
        [UIBarButtonItem lkx_barItemWithIcon:normalName
                                selectedIcon:selectedName
                                      target:self
                                      action:@selector(rightBarButtonAction:)];
}

/**
 *  @author 刘克邪
 *
 *  @brief  删除系统自动生成的UITabBarButton
 */
- (void)deleteSystemTabBarButton {
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  @author 刘克邪
 *
 *  @brief  APP本次启动是否登录成功
 *
 */
- (BOOL)currentLogin {
    return [kUserDefaults boolForKey:kAPPCurrentLogin];
}

#pragma mark - 控件响应方法
/**
 *  @author 刘克邪
 *
 *  @brief  navigator bar 左功能键响应
 */
- (void)leftBarButtonAction:(UIButton *)btn {
    [kMBHUDTool hideMBHUD:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  @author 刘克邪
 *
 *  @brief  navigator bar 右功能键响应
 */
- (void)rightBarButtonAction:(UIButton *)btn {};

#pragma mark - 网络请求
/**
 *  @author 刘克邪
 *
 *  @brief  请求数据
 */
- (void)reloadDataFromNetwork {}

/**
 *  @author 刘克邪
 *
 *  @brief  没有数据是展示的view
 */
- (void)showReloadView {
    LKXReloadView *reloadView = [[LKXReloadView alloc] initWithFrame:CGRectMake(0, 0, self.view.lkx_width, self.view.lkx_height)];
    reloadView.delegate = self;
    [self.view addSubview:reloadView];
}

#pragma mark - LKXReloadViewDelegate
/**
 *  @author 刘克邪
 *
 *  @brief  这里默认是调用reloadDataFromNetwork方法,如果需要调用其他方法就重写该方法
 */
- (void)reloadViewDidTouchUpInside:(LKXReloadView *)reloadView {
    [reloadView removeFromSuperview];
    reloadView = nil;
    [self reloadDataFromNetwork];
}

#pragma mark - UIViewControllerRestoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
}

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    UIViewController *vc = [[[self class] alloc] init];
    return vc;
}

@end
