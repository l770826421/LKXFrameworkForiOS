//
//  UIColor+Category.m
//  MyCategory
//
//  Created by lkx on 14-11-21.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "UIColor+category.h"

@implementation UIColor (Category)
/**
 通过16进制计算颜色
 
 @param inColorString 16进制
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

/**
 *  产生随机的颜色
 *
 *  @return UIColor
 */
+ (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0); //  0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;    //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
