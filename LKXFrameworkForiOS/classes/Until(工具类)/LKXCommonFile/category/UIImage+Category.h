//
//  UIImage+Category.h
//  malama_ca
//
//  Created by Developer on 15/4/28.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

#pragma mark - 类方法
/**
 *  拉伸图片
 *
 *  @param imageName 图片的名称
 *  @param width     距离左边的长度
 *  @param height    距离底部的长度
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)stretchImageWithImageName:(NSString *)imageName
                              andWidth:(float)width
                                height:(float)height;

#pragma mark - 实例方法
/**
 *  拉伸图片
 *
 *  @param width  距离左边的长度
 *  @param height 距离底部的长度
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)stretchImageWithWidth:(float)width
                         andHeight:(float)height;

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)imageWithColor:(UIColor *)color;

/*
 * 创建自定义大小的UIImage
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)aSize;

//得到压缩图片
- (NSString *)base64StringCompressImage;

/**
 *  将图片压缩
 *
 *  @return UIImage
 */
- (UIImage *)compressImage:(CGFloat)compress;

/**
 *  改变一个图片的颜色，但是它上面的颜色渐变不变,透明度不变
 *
 *  @param tintColor 要改成的颜色
 *  @param blendMode 重画模式 kCGBlendModeDestinationIn
 *
 *  @return UIImage
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
 *  等比率缩放图片
 *
 *  @param scaleSize 缩放比率
 *
 *  @return 缩放后的图片
 */
- (UIImage *)toScale:(CGFloat)scaleSize;

/**
 *  将image重画到自定size大小
 *
 *  @param reSize 重画的size大小
 *
 *  @return 重画后的大小
 */
- (UIImage *)reSize:(CGSize)reSize;

@end
