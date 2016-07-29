//
//  LKXBaseViewController.m
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXBaseViewController.h"

#import "LKXReloadView.h"

#import "MJRefresh.h"

@interface LKXBaseViewController () <LKXReloadViewDelegate>

@end

@implementation LKXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kAPPVCMainColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
- (void)isBackItem:(BOOL)isBackItem {
    _isBackItem = isBackItem;
    if (_isBackItem) {
        BigBtn *backButton = [BigBtn buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"icon_back"];
        backButton.frame = CGRectMake(0, 0, 30, 30);
        backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [backButton setImage:image forState:UIControlStateNormal];
        [backButton setShowsTouchWhenHighlighted:NO];
        [backButton addTarget:self action:@selector(btnActionBack) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)isSearchItem:(BOOL)isBackItem {
    _isSearchItem = isBackItem;
    if (_isSearchItem) {
        BigBtn *backButton = [BigBtn buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 30, 30);
        backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [backButton setImage:[UIImage imageNamed:@"icon_search_white"]
                    forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"icon_search_gray"]
                    forState:UIControlStateSelected];
        [backButton setShowsTouchWhenHighlighted:NO];
        [backButton addTarget:self action:@selector(btnActionSearch) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (LKXUser *)user {
    
    LKXUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:FILE_PATH_OF_DOCUMENT(kUserInfoFileName)];
    return user;
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
    LKXReloadView *reloadView = [[LKXReloadView alloc] initWithFrame:CGRectMake(0, 0, self.view.Width, self.view.Height)];
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
