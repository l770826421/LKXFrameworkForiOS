//
//  UIImage+Category.m
//  malama_ca
//
//  Created by Developer on 15/4/28.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "UIImage+Category.h"

// http://blog.csdn.net/xuhuan_wh/article/details/6434055
@implementation UIImage (Category)

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
                                height:(float)height
{
    UIImage *sourceImage = [UIImage imageNamed:imageName];
    UIImage *stretchImage = [sourceImage stretchImageWithWidth:width
                                                     andHeight:height];
    return stretchImage;
}

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
                         andHeight:(float)height
{
    UIImage *stretchImage = [self stretchableImageWithLeftCapWidth:width
                                                      topCapHeight:height];
    return stretchImage;
}

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    
    return [self imageWithColor:color size:rect.size];
}

/*
 * 创建自定义大小的UIImage
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)aSize
{
    UIGraphicsBeginImageContext(aSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, aSize.width, aSize.height));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//得到压缩图片
- (NSString *)base64StringCompressImage
{
    NSData *imgData = UIImageJPEGRepresentation(self,1);
    NSData *compressData;
    //如果是jpg格式
    if (imgData)
    {
        compressData = UIImageJPEGRepresentation(self,[self compressParameter:imgData]);
    }
    else    //如果是png格式
    {
        compressData = UIImagePNGRepresentation(self);
    }
    
    NSString *base64String = [compressData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    UIImage *img = [UIImage imageWithData:compressData];
    LKXMLog(@"oldsize == %@, compressSize == %@", NSStringFromCGSize(self.size), NSStringFromCGSize(img.size));
    return base64String;
}

/**
 *  将图片压缩
 *
 *  @param compress 压缩比例,当小于0则用compressParameter:获取压缩比例
 *
 *  @return UIImage
 */
- (UIImage *)compressImage:(CGFloat)compress
{
    NSData *imgData = UIImageJPEGRepresentation(self,1);
    NSData *compressData;
    //如果是jpg格式
    if (imgData)
    {
        compressData = UIImageJPEGRepresentation(self, compress >= 0 ? compress : [self compressParameter:imgData]);
    }
    else    //如果是png格式
    {
        compressData = UIImagePNGRepresentation(self);
    }
    UIImage *image = [UIImage imageWithData:compressData];
    return image;
}

//压缩系数
-(float)compressParameter:(NSData*)mydata
{
    if (mydata.length > (1024*1024*1.5) && mydata.length < (1024*1024*3))
    {
        return 0.1;
    }
    else if (mydata.length > (1024*1024*3))
    {
        return 0.08;
    }
    else
    {
        if (isIPad)
        {
            return 0.5;
        }
        return 0.2;
    }
}

//处理图片 照相有旋转
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/**
 *  改变一个图片的颜色，但是它上面的颜色渐变不变,透明度不变
 *
 *  @param tintColor 要改成的颜色
 *  @param blendMode 重画模式 kCGBlendModeDestinationIn
 *
 *  @return UIImage
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //保持图片的透明度,设置opaque为NO;用0.0f设置scale
    UIGraphicsBeginImageContextWithOptions(self.size, NO, .0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //重画image
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn)
    {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

/**
 *  等比率缩放图片
 *
 *  @param scaleSize 缩放比率
 *
 *  @return 缩放后的图片
 */
- (UIImage *)toScale:(CGFloat)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaleImage;
}

/**
 *  将image重画到自定size大小
 *
 *  @param reSize 重画的size大小
 *
 *  @return 重画后的大小
 */
- (UIImage *)reSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(reSize);
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

@end
