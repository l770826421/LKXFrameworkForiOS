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

extern NSString * const kAPPCurrentLogin;

/**
 *  @author 刘克邪
 *
 *  @brief  ViewController基类
 */
@interface LKXBaseViewController : UIViewController

/** 用户信息 */
@property (nonatomic, strong) LKXUser *user_sl;

/** 是否添加返回键,YES:添加;NO->不添加  */
@property (nonatomic, assign, setter=isBackItem:) BOOL isBackItem;

/**
 *  @author 刘克邪
 *
 *  @brief  APP本次启动是否登录成功
 *
 */
- (BOOL)currentLogin;

/**
 *  @author 刘克邪
 *
 *  @brief  navigationBar leftItem 示例化
 *
 *  @param normalName   normal image name
 *  @param selectedName selected image name
 */
- (void)rightItemImageWithNormalName:(NSString *)normalName selectedName:(NSString *)selectedName;

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