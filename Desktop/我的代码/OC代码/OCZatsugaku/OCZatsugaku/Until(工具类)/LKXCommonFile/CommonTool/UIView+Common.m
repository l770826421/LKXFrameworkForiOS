//
//  UIView+LKXCommon.m
//  ChatApp
//
//  Created by cnmobi1 on 13-9-13.
//  Copyright (c) 2013年 cnmobi1. All rights reserved.
//

#import "UIView+Common.h"
#import "BigBtn.h"

@implementation UIView (Common)

#pragma mark - 获取视图的上下左右宽高
- (void)setLkx_left:(CGFloat)lkx_left {
    CGRect frame = CGRectMake(lkx_left, self.lkx_top, self.lkx_width, self.lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_left {
    return self.frame.origin.x;
}

- (void)setLkx_top:(CGFloat)lkx_top {
    CGRect frame = CGRectMake(self.lkx_left, lkx_top, self.lkx_width, self.lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_top {
    return self.frame.origin.y;
}

- (CGFloat)lkx_right {
    return self.lkx_left + self.lkx_width;
}

- (CGFloat)lkx_bottom {
    return self.lkx_top + self.lkx_height;
}

- (void)setLkx_width:(CGFloat)lkx_width {
    CGRect frame = CGRectMake(self.lkx_left, self.lkx_top, lkx_width, self.lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_width {
    return self.frame.size.width;
}

- (void)setLkx_height:(CGFloat)lkx_height {
    CGRect frame = CGRectMake(self.lkx_left, self.lkx_top, self.lkx_width, lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_height {
    return self.frame.size.height;
}

#pragma mark - 获取视图的常用坐标
- (void)setLkx_frameOrigin:(CGPoint)lkx_frameOrigin
{
    CGRect frame = CGRectMake(lkx_frameOrigin.x, lkx_frameOrigin.y, self.lkx_width, self.lkx_height);
    self.frame = frame;
}

- (CGPoint)lkx_frameOrigin
{
    return self.frame.origin;
}

- (CGPoint)lkx_frameCenter
{
    return self.center;
}

- (void)setLkx_frameSize:(CGSize)lkx_frameSize
{
    CGRect frame = CGRectMake(self.lkx_left, self.lkx_top, lkx_frameSize.width, lkx_frameSize.height);
    self.frame = frame;
}

- (CGSize)lkx_frameSize
{
    return self.frame.size;
}

- (CGPoint)lkx_boundsOrigin
{
    return self.bounds.origin;
}

- (CGPoint)lkx_boundsCenter
{
    return CGPointMake(self.lkx_width * 0.5, self.lkx_height * 0.5);
}

- (CGSize)lkx_boundsSize {
    return self.bounds.size;
}

#pragma mark - 设置圆角,边框,边框颜色,背景颜色
/**
 设置圆角
 
 @param cornerRadius 圆角数
 */
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

/**
 这是表框线
 
 @param borderWidth 边框线粗
 @param borderColor 边框的颜色
 */
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

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
               borderColor:(UIColor *)borderColor
{
    if (bgColor)
    {
        [self setBackgroundColor:bgColor];
    }
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setBorderWidth:borderWidth];
    if (borderColor)
    {
        [self.layer setBorderColor:[borderColor CGColor]];
    }
    self.layer.masksToBounds = YES;
}


#pragma mark - 给视图添加一下划线
/*
 划线的起始坐标为左下角，frame的y值应该取到底部的距离
 */
-(void)addLineWithlineColor:(UIColor *)lineColor
                   andFrame:(CGRect)frame
{
    CGPoint leftPoint   = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height/2.0);
    CGPoint rightPoint  = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height/2.0);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftPoint];
    [path addLineToPoint:rightPoint];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.frame = self.bounds;
    lineLayer.geometryFlipped = YES;
    lineLayer.path = path.CGPath;
    lineLayer.strokeColor = lineColor.CGColor;
    lineLayer.lineWidth = frame.size.height;
    [self.layer addSublayer:lineLayer];
}




#pragma mark - SaveViewImage     //保存成为图片
-(UIImage *)SaveViewImage
{
    CGSize imageSize    = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return SaveImage;
}

#pragma mark -  //绘制可以带虚线框的View视图
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
                     borderColor:(UIColor *)borderColor
{

    [self setBackgroundColor:bgColor
                cornerRadius:cornerRadius
                 borderWidth:borderWidth
                 borderColor:[UIColor clearColor]];
    
    //drawing
    CGRect frame = self.bounds;
    
    CAShapeLayer *_shapeLayer = [CAShapeLayer layer];
    
    //creating a path
    CGMutablePathRef path = CGPathCreateMutable();
    
    //drawing a border around a view
    CGPathMoveToPoint(path, NULL, 0, frame.size.height - cornerRadius);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width - cornerRadius, 0);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height - cornerRadius);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, cornerRadius, frame.size.height);
    CGPathAddArc(path, NULL, cornerRadius, frame.size.height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
    
    //path is set as the _shapeLayer object's path
    _shapeLayer.path = path;
    CGPathRelease(path);
    
    _shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapeLayer.frame = frame;
    _shapeLayer.masksToBounds = NO;
    [_shapeLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isCircle"];
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    _shapeLayer.strokeColor = [borderColor CGColor];
    _shapeLayer.lineWidth = borderWidth;
    _shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInteger:dashPattern1], [NSNumber numberWithInteger:dashPattern2], nil];
    _shapeLayer.lineCap = kCALineCapRound;
    
    //_shapeLayer is added as a sublayer of the view
    [self.layer addSublayer:_shapeLayer];
    self.layer.cornerRadius = cornerRadius;
}





#pragma mark - addAnimation     //添加视图动画
/*
 
 视图添加一个动画
 参数：                描述
 Duration           动画时间
 AmtionType         动画类型
 AmtionFrom         动画方向
 
 */
-(void)addAnimationWithDuration:(CFTimeInterval)Duration
                  andAmtionType:(NSString *)AmtionType
                  andAmtionFrom:(NSString *)AmtionFrom
{
    CATransition *animation = [CATransition animation];
    animation.duration = Duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type      = AmtionType;
    animation.subtype   = AmtionFrom;
    
    [self.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - setShadow
/**
 设置视图阴影效果
 */
- (void) makeInsetShadow
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:0.5];
    
    UIView *shadowView = [self createShadowViewWithRadius:3 color:color directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

/**
 设置视图阴影效果
 
 @param radius 阴影的偏移大小
 @param alpha 透明度
 */
- (void) makeInsetShadowWithRadius:(float)radius alpha:(float)alpha
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:alpha];
    
    UIView *shadowView = [self createShadowViewWithRadius:radius color:color directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

/**
 设置视图阴影效果
 
 @param radius 阴影的偏移大小
 @param color 透明度
 @param directions 阴影散发方向
 */
- (void) makeInsetShadowWithRadius:(float)radius color:(UIColor *)color directions:(NSArray *)directions
{
    UIView *shadowView = [self createShadowViewWithRadius:radius color:color directions:directions];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

/**
 设置视图阴影效果
 
 @param radius 阴影的偏移大小
 @param alpha 透明度
 @param directions 阴影散发方向
 */
- (UIView *)createShadowViewWithRadius:(float)radius color:(UIColor *)color directions:(NSArray *)directions
{
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    shadowView.backgroundColor = [UIColor clearColor];
    
    // Ignore duplicate direction
    NSMutableDictionary *directionDict = [[NSMutableDictionary alloc] init];
    for (NSString *direction in directions) [directionDict setObject:@"1" forKey:direction];
    
    for (NSString *direction in directionDict) {
        // Ignore invalid direction
        if ([kValidDirections containsObject:direction])
        {
            CAGradientLayer *shadow = [CAGradientLayer layer];
            
            if ([direction isEqualToString:@"top"]) {
                [shadow setStartPoint:CGPointMake(0.5, 0.0)];
                [shadow setEndPoint:CGPointMake(0.5, 1.0)];
                shadow.frame = CGRectMake(0, 0, self.bounds.size.width, radius);
            }
            else if ([direction isEqualToString:@"bottom"])
            {
                [shadow setStartPoint:CGPointMake(0.5, 1.0)];
                [shadow setEndPoint:CGPointMake(0.5, 0.0)];
                shadow.frame = CGRectMake(0, self.bounds.size.height - radius, self.bounds.size.width, radius);
            } else if ([direction isEqualToString:@"left"])
            {
                shadow.frame = CGRectMake(0, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(0.0, 0.5)];
                [shadow setEndPoint:CGPointMake(1.0, 0.5)];
            } else if ([direction isEqualToString:@"right"])
            {
                shadow.frame = CGRectMake(self.bounds.size.width - radius, 0, radius, self.bounds.size.height);
                [shadow setStartPoint:CGPointMake(1.0, 0.5)];
                [shadow setEndPoint:CGPointMake(0.0, 0.5)];
            }
            
            shadow.colors = [NSArray arrayWithObjects:(id)[color CGColor], (id)[[UIColor clearColor] CGColor], nil];
            [shadowView.layer insertSublayer:shadow atIndex:0];
        }
    }
    
    return shadowView;
}




#pragma mark - CreateImageWithColor     //由UIColor创建图片
/**
 *  创建自定义大小的UIImage
 *
 *  @param color image的颜色
 *
 *  @return 自定的UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    return [self createImageWithColor:color rect:rect];
}

/**
 *  创建自定义大小的UIImage
 *
 *  @param color image的颜色
 *  @param aRect image大小
 *
 *  @return 自定的UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color
                             rect:(CGRect)aRect
{
    CGRect rect = aRect;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


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
                   userInteractionEnabled:(BOOL)userinterface
{
    UIImageView* ImageView = [[UIImageView alloc] initWithFrame:frame];
    [ImageView setImage:image];
    ImageView.userInteractionEnabled = userinterface;
    
    return ImageView;
}

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
                             action:(SEL)action
{
    BigBtn * btn = [BigBtn buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:color];
    [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [btn setBackgroundImage:hightedImg forState:UIControlStateHighlighted];
    [btn setBackgroundImage:hightedImg forState:UIControlStateSelected];
    [btn setImage:normalImg forState:UIControlStateNormal];
    [btn setImage:hightedImg forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setClipsToBounds:YES];
    
    return btn;
}

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
                   textAlignment:(NSTextAlignment)textalignment
{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:T_Color];
    [label setBackgroundColor:B_Color];
    [label setTextAlignment:textalignment];
    
    return label;
}

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
                           textAlignment:(NSTextAlignment)textAlignment
{
    UITextField *TextField = [[UITextField alloc]initWithFrame:frame];
    [TextField setFont:font];
    [TextField setTextColor:T_Color];
    [TextField setBackgroundColor:B_Color];
    [TextField setPlaceholder:placetext];
    [TextField setText:text];
    [TextField setTextAlignment:textAlignment];

    return TextField;
}

@end
