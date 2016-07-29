//
//  UIColor+Category.h
//  MyCategory
//
//  Created by lkx on 14-11-21.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)
/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

/**
 *  产生随机的颜色
 *
 *  @return UIColor
 */
+ (UIColor *)randomColor;

@end
