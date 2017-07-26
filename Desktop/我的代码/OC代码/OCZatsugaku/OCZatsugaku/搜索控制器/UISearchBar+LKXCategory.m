//
//  UISearchBar+LKXCategory.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/28.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "UISearchBar+LKXCategory.h"

@implementation UISearchBar (LKXCategory)

/**
 设置字体
 */
- (void)lkx_setTextFont:(UIFont *)font {
    if (Dev_IOSVersion >= 9.0) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil]
         setFont:font];
    }
}

/**
 设置字体颜色
 */
- (void)lkx_setTextColor:(UIColor *)textColor {
    if (Dev_IOSVersion >= 9.0) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil]setTextColor:textColor];
    }
}

/**
 设置取消button上文字
 */
- (void)lkx_setCancelButtonTitle:(NSString *)title {
    if (Dev_IOSVersion >= 9.0) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

/**
 设置取消button上文字字体
 */
- (void)lkx_setCancelButtonFont:(UIFont *)font {
    NSDictionary *textDic = @{NSFontAttributeName : font};
    if (Dev_IOSVersion >= 9.0) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:textDic
                                                                                                            forState:UIControlStateNormal];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:textDic
                                                                                            forState:UIControlStateNormal];
    }
}

@end
