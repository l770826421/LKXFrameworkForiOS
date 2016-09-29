//
//  UIView+LKXCommon.h
//  ChatApp
//
//  Created by cnmobi1 on 13-9-13.
//  Copyright (c) 2013年 cnmobi1. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kShadowViewTag 2132
#define kValidDirections [NSArray arrayWithObjects: @"top", @"bottom", @"left", @"right",nil]



@interface UIView (Common)

#pragma mark - 获取视图的上下左右宽高
- (float)Top;            //上
- (float)Bottom;         //下
- (float)Left;           //左
- (float)Right;          //右
- (float)Width;          //宽
- (float)Height;         //高


#pragma mark - 获取视图的常用坐标
- (CGPoint)FrameOrigin;      //FramePoint
- (CGPoint)FrameCenter;      //FrameCenter
- (CGSize)FrameSize;         //FrameSize

- (CGPoint)BoundsOrigin;     //BoundsPoint
- (CGPoint)BoundsCenter;     //BoundsCenter
- (CGSize)BoundsSize;        //BoundsSize


#pragma mark - 设置圆角,边框,边框颜色,背景颜色
//设置圆角,边框,边框颜色,背景颜色
- (void)setBackgroundColor:(UIColor *)BGColor
          andCornerRadius:(float)Radius     //5.0
           andBorderWidth:(float)Width      //2.0
           andBorderColor:(UIColor *)Color;


#pragma mark - 给视图添加一下划线
/*
 划线的起始坐标为左下角，frame的y值应该取到底部的距离
 */
- (void)addLineWithlineColor:(UIColor *)lineColor
                   andFrame:(CGRect)frame;


#pragma mark - SaveViewImage     保存成为图片
- (UIImage *)SaveViewImage;

#pragma mark -  绘制可以带虚线框的View视图
- (void)setShapeLayerWithBGColor:(UIColor *)BGColor         //背景色
                  andCornerRadiu:(CGFloat)CornerRadiu       //圆角度数
                  andBorderWidth:(CGFloat)BorderWidth       //线宽
                     andPattern1:(NSInteger)Pattern1        //虚线1长度
                     andPattern2:(NSInteger)Pattern2        //虚线2长度
                  andBorderColor:(UIColor *)BorderColor;    //虚线颜色



#pragma mark - addAnimation     添加视图动画
-(void)addAnimationWithDuration:(CFTimeInterval)Duration
                  andAmtionType:(NSString *)AmtionType
                  andAmtionFrom:(NSString *)AmtionFrom;



#pragma mark - setShadow        设置视图阴影效果
- (void)makeInsetShadow;
- (void)makeInsetShadowWithRadius:(float)radius
                            Alpha:(float)alpha;
- (void)makeInsetShadowWithRadius:(float)radius
                            Color:(UIColor *)color
                       Directions:(NSArray *)directions;



#pragma mark - CreateImageWithColor     由UIColor创建图片
/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color;

/*
 * 创建自定义大小的UIImage
 *
 */
+ (UIImage *)createImageWithColor:(UIColor *)color
                             rect:(CGRect)aRect;




#pragma mark - AllViews
+ (UIImageView *)createImageViewWithImage:(UIImage *)image
                               andFrame:(CGRect)frame
              andUserInteractionEnabled:(BOOL)userinterface;


+ (UIButton *)createButtonWithTitle:(NSString *)title
                         andFrame:(CGRect)frame
                          andType:(UIButtonType)type
               andBackGroundColor:(UIColor *)color
          andBackGroundIMg_Normal:(UIImage *)normalImg
         andBackGroundIMG_Highted:(UIImage *)hightedImg
                        andTarget:(id)tag
                        andAction:(SEL)action;

+ (UILabel *)createLabelWithText:(NSString *)text
                      andFrame:(CGRect)frame
                       andFont:(UIFont *)font
                  andTextColor:(UIColor *)T_Color
            andBackgroundColor:(UIColor *)B_Color
              andTextAlignment:(NSTextAlignment)textalignment;


+ (UITextField *)createTextFieldWithText:(NSString *)text
                               andFrame:(CGRect)frame
                                andFont:(UIFont *)font
                           andTextColor:(UIColor *)T_Color
                     andBackgroundColor:(UIColor *)B_Color
                           andPlacetext:(NSString *)placetext
                       andTextAlignment:(NSTextAlignment)textAlignment;

@end
