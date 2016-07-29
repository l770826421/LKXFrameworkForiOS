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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @author 刘克邪
 *
 *  @brief  当只有scroll一个子视图,添加scroll到self.view,并对scroll布局
 */
- (void)autolayoutScroll {
    [self.view addSubview:self.scroll];
    [self.view addConstraints:[NSLayoutConstraint lkx_constraintsWithScroll:self.scroll]];
}

#pragma mark - setter and getter
//@synthesize scroll = _scroll;
- (UIScrollView *)scroll {
    
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.translatesAutoresizingMaskIntoConstraints = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [block_self downRefreshData];
    }];
    mj_header.backgroundColor = scroll.backgroundColor;
    
    scroll.mj_header = mj_header;
}

/**
 *  @author 刘克邪
 *
 *  @brief  上拉获取数据
 */
- (void)downRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scroll.mj_header endRefreshing];
    });
}

/**
 *  @author 刘克邪
 *
 *  @brief  添加上拉刷新
 */
- (void)addFooterInScrollView:(UIScrollView *)scroll {
    __block LKXScrollViewController *block_self = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [block_self pullRefreshData];
    }];
    [mj_footer setTitle:@"" forState:MJRefreshStateIdle];
    mj_footer.automaticallyRefresh = NO;
    mj_footer.triggerAutomaticallyRefreshPercent = 0;
    mj_footer.backgroundColor = scroll.backgroundColor;
//    mj_footer.automaticallyHidden = YES;
//    mj_footer.ignoredScrollViewContentInsetBottom = 1;
    
    scroll.mj_footer = mj_footer;
}

/**
 *  @author 刘克邪
 *
 *  @brief  上拉获取数据
 */
- (void)pullRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.scroll.mj_footer endRefreshing];
    });
}

/**
 *  @author 刘克邪
 *
 *  @brief  添加置顶button
 */
- (UIButton *)topBtn {
    if (!_topBtn) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_topBtn setImage:[UIImage imageNamed:@"sl_commodity_list_back_top"] forState:UIControlStateNormal];
        [_topBtn addTarget:self
                        action:@selector(btnActionTop:)
              forControlEvents:UIControlEventTouchUpInside];
        _topBtn.hidden = YES;
    }
    return _topBtn;
}

/**
 *  @author 刘克邪
 *
 *  @brief  返回顶部
 *
 */
- (void)btnActionTop:(UIButton *)topBtn {
    [self.scroll scrollsToTop];
}

@end
