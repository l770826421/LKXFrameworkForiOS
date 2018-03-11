//
//  UIColor+LKXCategory.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 14-11-21.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LKXCategory)
/**
 通过16进制计算颜色
 
 @param inColorString 16进制
 */
+ (UIColor *)lkx_colorFromHexRGB:(NSString *)inColorString;

/**
 *  产生随机的颜色
 *
 *  @return UIColor
 */
+ (UIColor *)lkx_randomColor;

@end
