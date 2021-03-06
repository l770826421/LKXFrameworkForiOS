//
//  LKXBaseViewController.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKXReloadView;

extern NSString * const kAPPCurrentLogin;

/**
 *  @author 刘克邪
 *
 *  @brief  ViewController基类
 */
@interface LKXBaseViewController : UIViewController

/**
 *  @author 刘克邪
 *
 *  @brief  删除系统自动生成的UITabBarButton
 */
- (void)deleteSystemTabBarButton;


/**
 *  @author 刘克邪
 *
 *  @brief  APP本次启动是否登录成功
 *
 */
- (BOOL)currentLogin;

/**
 Navigator bar 左功能键
 
 @param imageName 对应的图片
 */
- (void)leftBarButtonItemWithImageName:(NSString *)imageName;

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
 *  @brief  navigator bar 左功能键响应
 */
- (void)leftBarButtonAction:(UIButton *)btn;

/**
 *  @author 刘克邪
 *
 *  @brief  navigator bar 右功能键响应
 */
- (void)rightBarButtonAction:(UIButton *)btn;

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
