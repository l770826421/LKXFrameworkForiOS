//
//  LKXBaseViewController.m
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXBaseViewController.h"

#import "UIBarButtonItem+LKX.h"
#import "LKXReloadView.h"

#import "LKXUser.h"

#import "MJRefresh.h"

NSString * const kAPPCurrentLogin = @"kAPPCurrentLogin";

@interface LKXBaseViewController () <LKXReloadViewDelegate>

@end

@implementation LKXBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kAPPVCMainColor;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kMBHUDTool hideMBHUD:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
- (void)isBackItem:(BOOL)isBackItem {
    _isBackItem = isBackItem;
    if (_isBackItem) {
        
        self.navigationItem.leftBarButtonItem =
            [UIBarButtonItem lkx_backBarItemWithIcon:@"icon_back"
                                          target:self
                                          action:@selector(btnActionBack)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
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
                                      action:@selector(btnActionSearch)];
}

/**
 *  @author 刘克邪
 *
 *  @brief  用户信息
 *
 */
@synthesize user_sl = _user_sl;
- (LKXUser *)user_sl {
    if ([self currentLogin]) {
        if (!_user_sl) {
            LKXUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:FILE_PATH_OF_DOCUMENT(SLUserFilename)];
            _user_sl = user;
        }
    } else {
        _user_sl = nil;
    }
    return _user_sl;
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
- (void)btnActionBack {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  @author 刘克邪
 *
 *  @brief  搜索
 */
- (void)btnActionSearch {};

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

@end
