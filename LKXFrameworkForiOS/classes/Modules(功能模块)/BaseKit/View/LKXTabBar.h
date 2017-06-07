//
//  LKXTabBar.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKXTabBar;

@protocol LKXTabBarDelegate <NSObject>

@optional
- (void)tabBar:(LKXTabBar *)tabBar didSelectedFormIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex;;

@end

/**
 *  @author 刘克邪
 *
 *  @brief  自定义TabBar
 */
@interface LKXTabBar : UIView

@property (nonatomic, weak) id<LKXTabBarDelegate> delegate;

+ (instancetype)tabBar;

/**
 *  @author 刘克邪
 *
 *  @brief  添加选项卡
 */
- (void)addTabBarButton:(UITabBarItem *)item;

/**
 *  @author 刘克邪
 *
 *  @brief  手动设置选中的item
 *
 *  @param index item的索引
 */
- (void)selectIndex:(NSUInteger)index;

@end
