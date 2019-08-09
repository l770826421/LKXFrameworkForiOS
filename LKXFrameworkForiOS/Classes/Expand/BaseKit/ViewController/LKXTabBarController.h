//
//  LKXTabBarController.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKXTabBarItemModel.h"

/**
 *  @author 刘克邪
 *
 *  @brief  随行项目的TabBarController
 */
@interface LKXTabBarController : UITabBarController


/**
 添加子视图

 @param item 子视图模型
 */
- (void)addChildViewControllerWithItem:(LKXTabBarItemModel *)item;

@end
