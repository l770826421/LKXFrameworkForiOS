//
//  LKXScrollViewController.h
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXBaseViewController.h"
#import "MJRefresh.h"

/**
 *  @author 刘克邪
 *
 *  @brief  ViewController基类
 */
@interface LKXScrollViewController : LKXBaseViewController <UIScrollViewDelegate>

/** 需要使用scrollView的VC,这里是用AutoLayout */
@property (nonatomic, strong) UIScrollView *scroll;

/** 返回顶部button,默认不显示,隐藏 */
@property (nonatomic, strong) UIButton *topBtn;
/**
 *  @author 刘克邪
 *
 *  @brief  返回顶部
 *
 */
- (void)btnActionTop:(UIButton *)topBtn;

/**
 *  @author 刘克邪
 *
 *  @brief  当只有scroll一个子视图,添加scroll到self.view,并对scroll布局
 */
- (void)autolayoutScroll;

#pragma mark - 其他方法
/**
 *  @author 刘克邪
 *
 *  @brief  添加下拉刷新
 */
- (void)addHeaderInScrollView:(UIScrollView *)scroll;

/**
 *  @author 刘克邪
 *
 *  @brief  上拉获取数据
 */
- (void)downRefreshData;

/**
 *  @author 刘克邪
 *
 *  @brief  添加上拉刷新
 */
- (void)addFooterInScrollView:(UIScrollView *)scroll;

/**
 *  @author 刘克邪
 *
 *  @brief  下拉获取数据
 */
- (void)pullRefreshData;

@end