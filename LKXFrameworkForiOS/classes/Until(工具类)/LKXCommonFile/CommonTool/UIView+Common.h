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
/** X坐标 */
@property (nonatomic, assign) CGFloat lkx_left;
/** y坐标 */
@property (nonatomic, assign) CGFloat lkx_top;
/** 最右边x坐标 */
@property (nonatomic, assign, readonly) CGFloat lkx_right;
/** 最底部y坐标 */
@property (nonatomic, assign, readonly) CGFloat lkx_bottom;
/** width */
@property (nonatomic, assign) CGFloat lkx_width;
/** height */
@property (nonatomic, assign) CGFloat lkx_height;


#pragma mark - 获取视图的常用坐标
/** frame origin */
@property (nonatomic, assign) CGPoint lkx_frameOrigin;
/** frame center */
@property (nonatomic, assign, readonly) CGPoint lkx_frameCenter;
/** frame size */
@property (nonatomic, assign) CGSize lkx_frameSize;
/** bounds origin */
@property (nonatomic, assign, readonly) CGPoint lkx_boundsOrigin;
/** bounds center */
@property (nonatomic, assign, readonly) CGPoint lkx_boundsCenter;
/** bounds size */
@property (nonatomic, assign, readonly) CGSize lkx_boundsSize;

#pragma mark - 设置圆角,边框,边框颜色,背景颜色

/**
 设置圆角

 @param cornerRadius 圆角数
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;

/**
 这是表框线

 @param borderWidth 边框线粗
 @param borderColor 边框的颜色
 */
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 设置圆角,边框,边框颜色,背景颜色

 @param bgColor 背景颜色
 @param cornerRadius 圆角,默认5.0
 @param borderWidth 边框线粗,默认2.0
 @param borderColor 边框颜色
 */
- (void)setBackgroundColor:(UIColor *)bgColor
              cornerRadius:(CGFloat)cornerRadius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor;


#pragma mark - 给视图添加一下划线
/*
 划线的起始坐标为左下角，frame的y值应该取到底部的距离
 */
- (void)addLineWithlineColor:(UIColor *)lineColor
                   andFrame:(CGRect)frame;


#pragma mark - SaveViewImage
/**
 保存图片
 */
- (UIImage *)SaveViewImage;

#pragma mark -  绘制可以带虚线框的View视图
/**
 绘制可以带虚线框的View视图
 
 @param bgColor 背景色
 @param cornerRadius 圆角度数
 @param borderWidth 线宽
 @param dashPattern1 虚线1长度
 @param dashPattern2 虚线2长度
 @param borderColor 虚线颜色
 */
- (void)setShapeLayerWithBGColor:(UIColor *)bgColor
                    cornerRadius:(CGFloat)cornerRadius
                     borderWidth:(CGFloat)borderWidth
                    dashPattern1:(NSInteger)dashPattern1
                    dashPattern2:(NSInteger)dashPattern2
                     borderColor:(UIColor *)borderColor;

#pragma mark - addAnimation    

/**
 添加视图动画

 @param Duration 动画时间
 @param AmtionType 动画类型
 @param AmtionFrom 动画方向
 */
-(void)addAnimationWithDuration:(CFTimeInterval)Duration
                  andAmtionType:(NSString *)AmtionType
                  andAmtionFrom:(NSString *)AmtionFrom;

#pragma mark - setShadow        设置视图阴影效果
/**
 设置视图阴影效果
 */
- (void)makeInsetShadow;

/**
 设置视图阴影效果

 @param radius 阴影的偏移大小
 @param alpha 透明度
 */
- (void)makeInsetShadowWithRadius:(float)radius
                            alpha:(float)alpha;
/**
 设置视图阴影效果
 
 @param radius 阴影的偏移大小
 @param color 透明度
 @param directions 阴影散发方向
 */
- (void)makeInsetShadowWithRadius:(float)radius
                            color:(UIColor *)color
                       directions:(NSArray *)directions;



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
/**
 创建一个可响应点击imageview
 
 @param image 图片对象
 @param frame frame
 @param userinterface 是否开启交互
 @return UIImageView
 */
+ (UIImageView *)createImageViewWithImage:(UIImage *)image
                                    frame:(CGRect)frame
                   userInteractionEnabled:(BOOL)userinterface;

/**
 创建一个UIButton
 
 @param title 文字
 @param frame frame
 @param type 按键类型
 @param color 背景颜色
 @param normalImg 按键未按下正常图片
 @param hightedImg 按键按下高亮图片
 @param target 事件响应者
 @param action 事件执行函数
 @return UIButton
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                              frame:(CGRect)frame
                               type:(UIButtonType)type
                    backGroundColor:(UIColor *)color
               backGroundIMg_Normal:(UIImage *)normalImg
              backGroundIMG_Highted:(UIImage *)hightedImg
                             target:(id)target
                             action:(SEL)action;

/**
 创建一个UILabel
 
 @param text 文字
 @param frame frame
 @param font 文字格式
 @param T_Color 文字颜色
 @param B_Color 背景颜色
 @param textalignment 文字排版
 @return UILabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                           frame:(CGRect)frame
                            font:(UIFont *)font
                       textColor:(UIColor *)T_Color
                 backgroundColor:(UIColor *)B_Color
                   textAlignment:(NSTextAlignment)textalignment;

/**
 创建一个UITextField
 
 @param text 文字
 @param frame frame
 @param font 文字格式
 @param T_Color 文字颜色
 @param B_Color 背景颜色
 @param placetext 提示文字
 @param textAlignment 文字排版
 @return UITextField
 */
+ (UITextField *)createTextFieldWithText:(NSString *)text
                                   frame:(CGRect)frame
                                    font:(UIFont *)font
                               textColor:(UIColor *)T_Color
                         backgroundColor:(UIColor *)B_Color
                               placetext:(NSString *)placetext
                           textAlignment:(NSTextAlignment)textAlignment;
@end
