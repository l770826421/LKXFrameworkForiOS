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
- (float)Top
{
    float length = 0.0;
    length = self.frame.origin.y;
    return length;
}

- (float)Bottom
{
    float length = 0.0;
    length = self.frame.origin.y + self.frame.size.height;
    return length;
}


- (float)Left
{
    float length = 0.0;
    length = self.frame.origin.x;
    return length;
}


- (float)Right
{
    float length = 0.0;
    length = self.frame.origin.x + self.frame.size.width;
    return length;
}



- (float)Width
{
    float length = 0.0;
    length = self.frame.size.width;
    return length;
}


- (float)Height
{
    float length = 0.0;
    length = self.frame.size.height;
    return length;
}

#pragma mark - 获取视图的常用坐标
- (CGPoint)FrameOrigin
{
    return  self.frame.origin;
}


- (CGSize)FrameSize
{
    return  self.frame.size;
}


- (CGPoint)FrameCenter
{
    return  self.center;
}



- (CGPoint)BoundsOrigin
{
    return  self.bounds.origin;
}


- (CGSize)BoundsSize
{
    return  self.bounds.size;
}


- (CGPoint)BoundsCenter
{
    return  CGPointMake(self.Width/2.0, self.Height/2.0);
}




#pragma mark - 设置圆角,边框,边框颜色,背景颜色
//设置圆角,边框,边框颜色,背景颜色
-(void)setBackgroundColor:(UIColor *)BGColor
          andCornerRadius:(float)Radius
           andBorderWidth:(float)Width
           andBorderColor:(UIColor *)BorderColor
{
    if (BGColor)
        [self setBackgroundColor:BGColor];
    [self.layer setCornerRadius:Radius];
    [self.layer setBorderWidth:Width];
    if (BorderColor)
        [self.layer setBorderColor:[BorderColor CGColor]];
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
//绘制可以呆虚线框的View视图
- (void)setShapeLayerWithBGColor:(UIColor *)BGColor         //背景色
                  andCornerRadiu:(CGFloat)CornerRadiu       //圆角度数
                  andBorderWidth:(CGFloat)BorderWidth       //线宽
                     andPattern1:(NSInteger)Pattern1        //虚线1长度
                     andPattern2:(NSInteger)Pattern2        //虚线2长度
                  andBorderColor:(UIColor *)BorderColor     //虚线颜色
{
    //border definitions
    CGFloat     cornerRadius    = CornerRadiu;
    CGFloat     borderWidth     = BorderWidth;
    NSInteger   dashPattern1    = Pattern1;
    NSInteger   dashPattern2    = Pattern2;
    UIColor     *lineColor      = BorderColor;
    
    
    [self setBackgroundColor:BGColor
             andCornerRadius:CornerRadiu
              andBorderWidth:BorderWidth
              andBorderColor:[UIColor clearColor]];
    
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
    _shapeLayer.strokeColor = [lineColor CGColor];
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
- (void) makeInsetShadow
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:0.5];
    
    UIView *shadowView = [self createShadowViewWithRadius:3 Color:color Directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}


- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha
{
    NSArray *shadowDirections = [NSArray arrayWithObjects:@"top", @"bottom", @"left" , @"right" , nil];
    UIColor *color = [UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:alpha];
    
    UIView *shadowView = [self createShadowViewWithRadius:radius Color:color Directions:shadowDirections];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
{
    UIView *shadowView = [self createShadowViewWithRadius:radius Color:color Directions:directions];
    shadowView.tag = kShadowViewTag;
    
    [self addSubview:shadowView];
}

- (UIView *) createShadowViewWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions
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
/*
 
 创建一个UIImageView
 参数：                描述
 image              图片
 frame              Frame设定
 userinterface      是否开启交互
 
 */
+ (UIImageView *)createImageViewWithImage:(UIImage *)image
                               andFrame:(CGRect)frame
              andUserInteractionEnabled:(BOOL)userinterface
{
    UIImageView* ImageView = [[UIImageView alloc]initWithFrame:frame];
    [ImageView setImage:image];
    ImageView.userInteractionEnabled = userinterface;
    
    return ImageView;
}


/*
 
 创建一个UIButton
 参数：                描述
 title              文字
 frame              Frame设定
 type               按键类型
 color              背景颜色
 normalImg          按键未按下正常图片
 hightedImg         按键按下高亮图片
 target             事件响应者
 action             事件执行函数
 
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                          andFrame:(CGRect)frame
                           andType:(UIButtonType)type
                andBackGroundColor:(UIColor *)color
           andBackGroundIMg_Normal:(UIImage *)normalImg
          andBackGroundIMG_Highted:(UIImage *)hightedImg
                         andTarget:(id)target
                         andAction:(SEL)action
{
    BigBtn * btn = [BigBtn buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
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



/*
 
 创建一个UILabel
 参数：                描述
 text              文字
 frame              Frame设定
 font               文字格式
 T_Color            文字颜色
 B_Color            背景颜色
 textalignment      文字排版
 
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                      andFrame:(CGRect)frame
                       andFont:(UIFont *)font
                  andTextColor:(UIColor *)T_Color
            andBackgroundColor:(UIColor *)B_Color
              andTextAlignment:(NSTextAlignment)textalignment
{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    [label setText:text];
    [label setFont:font];
    [label setTextColor:T_Color];
    [label setBackgroundColor:B_Color];
    [label setTextAlignment:textalignment];
    
    return label;
}


/*
 创建一个UITextField
 参数：                描述
 text              文字
 frame              Frame设定
 font               文字格式
 T_Color            文字颜色
 B_Color            背景颜色
 placetext          提示文字
 textalignment      文字排版
 
 */
+ (UITextField *)createTextFieldWithText:(NSString *)text
                               andFrame:(CGRect)frame
                                andFont:(UIFont *)font
                           andTextColor:(UIColor *)T_Color
                     andBackgroundColor:(UIColor *)B_Color
                           andPlacetext:(NSString *)placetext
                       andTextAlignment:(NSTextAlignment)textAlignment
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
