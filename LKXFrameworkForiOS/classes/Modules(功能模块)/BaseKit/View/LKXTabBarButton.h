//
//  LKXTabBarButton.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author 刘克邪
 *
 *  @brief  自定义tabBar的item
 */
@interface LKXTabBarButton : UIButton

// 用item的内容设置button
@property (nonatomic, strong) UITabBarItem *item;

@end
