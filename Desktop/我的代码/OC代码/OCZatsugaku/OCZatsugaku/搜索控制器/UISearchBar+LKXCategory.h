//
//  UISearchBar+LKXCategory.h
//  OCZatsugaku
//
//  Created by lkx on 2017/6/28.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 为系统搜索bar添加方法，定制UI风格
 */
@interface UISearchBar (LKXCategory)

/**
 设置字体
 */
- (void)lkx_setTextFont:(UIFont *)font;

/**
 设置字体颜色
 */
- (void)lkx_setTextColor:(UIColor *)textColor;

/**
 设置取消button上文字
 */
- (void)lkx_setCancelButtonTitle:(NSString *)title;

/**
 设置取消button上文字字体
 */
- (void)lkx_setCancelButtonFont:(UIFont *)font;

@end
