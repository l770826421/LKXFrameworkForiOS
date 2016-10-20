//
//  LKXTabBarController.m
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTabBarController.h"

#import "LKXNavigationController.h"

#import "LKXBaseViewController.h"
#import "LKXcardPassesViewController.h"

#import "LKXTabBar.h"

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
    [self setupChildVCs];
}

- (void)initTabBar {
    LKXTabBar *tabBar = [LKXTabBar tabBar];
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    
    self.tabBarView = tabBar;
}

- (void)setupChildVCs {
    LKXcardPassesViewController *cardPassesVC = [[LKXcardPassesViewController alloc] init];
    [self addChildVC:cardPassesVC
        andItemTitle:@"一卡通"
         normalImage:@"icon_home_normal"
       selectedImage:@"icon_home_hightlight"];
    
    LKXBaseViewController *eportVC = [[LKXBaseViewController alloc] init];
    [self addChildVC:eportVC
        andItemTitle:@"集港计划"
         normalImage:@"icon_order_normal"
       selectedImage:@"icon_order_hightlight"];
    
    LKXBaseViewController *peopleCenterVC = [[LKXBaseViewController alloc] init];
    [self addChildVC:peopleCenterVC
        andItemTitle:@"个人中心"
         normalImage:@"icon_user_normal"
       selectedImage:@"icon_user_hightlight"];
}

- (void)addChildVC:(UIViewController *)vc andItemTitle:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:normalImage];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self.tabBarView addTabBarButton:vc.tabBarItem];
    
    LKXNavigationController *navigationCtl = [[LKXNavigationController alloc] initWithRootViewController:vc];
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
