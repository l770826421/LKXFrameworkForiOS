//
//  LKXBaseViewController.h
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKXReloadView;
@class LKXUser;

/**
 *  @author 刘克邪
 *
 *  @brief  ViewController基类
 */
@interface LKXBaseViewController : UIViewController

/** 用户信息 */
@property (nonatomic, strong, readonly) LKXUser *user;

/** 是否添加返回键,YES:添加;NO->不添加  */
@property (nonatomic, assign, setter=isBackItem:) BOOL isBackItem;
/** 是否添加搜索键,YES:添加;NO->不添加  */
@property (nonatomic, assign, setter=isSearchItem:) BOOL isSearchItem;

#pragma mark - 控件响应方法
/**
 *  @author 刘克邪
 *
 *  @brief pop方法,如果不是pop上一个界面,则重写该方法
 */
- (void)btnActionBack;

/**
 *  @author 刘克邪
 *
 *  @brief  搜索
 */
- (void)btnActionSearch;

#pragma mark - 网络请求
/**
 *  @author 刘克邪
 *
 *  @brief  请求数据
 */
- (void)reloadDataFromNetwork;

/**
 *  @author 刘克邪
 *
 *  @brief  没有数据是展示的view
 */
- (void)showReloadView;
@end