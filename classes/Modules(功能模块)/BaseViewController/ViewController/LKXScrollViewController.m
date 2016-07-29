//
//  LKXScrollViewController.m
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXScrollViewController.h"

#import "LKXLayoutContraint.h"

@interface LKXScrollViewController ()

@end

@implementation LKXScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kAPPVCMainColor;
    
    [self.view addSubview:self.scroll];
    [self.view addConstraints:[NSLayoutConstraint lkx_constraintsWithScroll:self.scroll]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
@synthesize scroll = _scroll;
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.translatesAutoresizingMaskIntoConstraints = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
    }
    
    return _scroll;
}

#pragma mark - 其他方法
/**
 *  @author 刘克邪
 *
 *  @brief  添加下拉刷新
 */
- (void)addHeaderInScrollView:(UIScrollView *)scroll {
    __block LKXScrollViewController *block_self = self;
    [scroll addHeaderWithCallback:^{
        [block_self downRefreshData];
    }];
}

/**
 *  @author 刘克邪
 *
 *  @brief  上拉获取数据
 */
- (void)downRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scroll headerEndRefreshing];
    });
}

/**
 *  @author 刘克邪
 *
 *  @brief  添加上拉刷新
 */
- (void)addFooterInScrollView:(UIScrollView *)scroll {
    __block LKXScrollViewController *block_self = self;
    [scroll addFooterWithCallback:^{
        [block_self pullRefreshData];
    }];
}

/**
 *  @author 刘克邪
 *
 *  @brief  下拉获取数据
 */
- (void)pullRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scroll footerEndRefreshing];
    });
}

@end
