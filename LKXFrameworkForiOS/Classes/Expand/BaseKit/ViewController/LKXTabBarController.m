//
//  LKXTabBarController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTabBarController.h"
#import "UIColor+LKXCategory.h"

#import "LKXNavigationController.h"

#import "LKXTabBar.h"
#import "LKXConstString.h"
#import "Macros_UICommon.h"

/*********** UITabBar ***************/
#define kTabBarItemFontColorNormal ColorWithHex(@"7a7e83")
#define kTabBarItemFontColorSelected ColorWithHex(@"7a7e83")

@interface LKXTabBarController () <LKXTabBarDelegate>

@property (nonatomic, weak) LKXTabBar *tabBarView;

@end

@implementation LKXTabBarController
/**
 *  @author 刘克邪
 *
 *  @brief  第一次实例化时item的某些状态是一次设定好,不需要再改变的
 */
+ (void)initialize {
    // 字体大小
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize : kTabBarItemFontSize]} forState:UIControlStateNormal];
    // 字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : kTabBarItemFontColorNormal} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kTabBarItemFontColorSelected} forState:UIControlStateSelected];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[LKXTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabBar];
}

- (void)initTabBar {
    LKXTabBar *tabBar = [LKXTabBar tabBar];
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    
    self.tabBarView = tabBar;
}

/**
 添加子视图
 
 @param item 子视图模型
 */
- (void)addChildViewControllerWithItem:(LKXTabBarItemModel *)item {
    item.viewController.tabBarItem.title = item.title;
    item.viewController.tabBarItem.image = item.normalImage;
    item.viewController.tabBarItem.selectedImage = item.selectedImage;
    
    [self.tabBarView addTabBarButton:item.viewController.tabBarItem];
    
    LKXNavigationController *navigationCtl = [[LKXNavigationController alloc] initWithRootViewController:item.viewController];
    [self addChildViewController:navigationCtl];
}


#pragma mark - LKXTabBarDelegate 
- (void)tabBar:(LKXTabBar *)tabBar didSelectedFormIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex {
    self.selectedIndex = toIndex;
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    [super setSelectedIndex:selectedIndex];
    [self.tabBarView selectIndex:selectedIndex];
}


@end
