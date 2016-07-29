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
@interface LKXScrollViewController : LKXBaseViewController

/** 需要使用scrollView的VC,这里是用AutoLayout */
@property (nonatomic, strong) UIScrollView *scroll;

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