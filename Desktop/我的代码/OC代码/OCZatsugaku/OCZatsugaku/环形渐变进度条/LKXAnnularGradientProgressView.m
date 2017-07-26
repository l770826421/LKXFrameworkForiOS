//
//  LKXAnnularGradientProgressView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/26.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXAnnularGradientProgressView.h"

#define LKX_DEGREES_TO_RADOANS(x) (M_PI * (x) / 180.0) // 将角度转为弧度
#define LKX_START_ANGLE LKX_DEGREES_TO_RADOANS(-240)
#define LKX_END_ANGLE LKX_DEGREES_TO_RADOANS(60)

/** 
 *  mask可见部分
 *  CAShapeLayer 遮罩效果
 */

@interface LKXAnnularGradientProgressView ()

/** 背景色遮罩 */
@property(nonatomic, strong) CAShapeLayer *backgroundMaskLayer;
/** 渐变色 */
@property(nonatomic, strong) CAShapeLayer *colorsLayer;
/** 渐变色遮罩 */
@property(nonatomic, strong) CAShapeLayer *colorMaskLayer;

@end

@implementation LKXAnnularGradientProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_init];
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        [self p_init];
//    }
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self p_init];
}

- (void)p_init {
    self.backgroundColor = [UIColor blueColor];
    _type = LKXClockWiseTypeNO;
    _lineWidth = 20;
    [self p_setupColorsLayer];
    [self p_setupColorMaskLayer];
    [self p_setupBackgroundMaskLayer];
}

/**
 设置背景遮罩
 */
- (void)p_setupBackgroundMaskLayer {
    CAShapeLayer *layer = [self p_generateMaskLayer];
    self.layer.mask = layer;
    self.backgroundMaskLayer = layer;
}

- (void)p_setupColorsLayer {
    self.colorsLayer = [CAShapeLayer layer];
    self.colorsLayer.frame = self.bounds;
    [self.layer addSublayer:self.colorsLayer];
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.lkx_width * 0.5, self.lkx_height);
    // 分段设置渐变色
    leftLayer.locations = @[@0.3, @0.9, @1];
    leftLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor greenColor].CGColor];
    [self.colorsLayer addSublayer:leftLayer];
    
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.lkx_width * 0.5, 0, self.lkx_width * 0.5, self.lkx_height);
    rightLayer.locations = @[@0.3, @0.9, @1];
    rightLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor];
    [self.colorsLayer addSublayer:rightLayer];
}

/**
 设置渐变色遮罩
 */
- (void)p_setupColorMaskLayer {
    CAShapeLayer *layer = [self p_generateMaskLayer];
    // 渐变遮罩线宽较大，防止背景遮罩有边露出
    layer.lineWidth = _lineWidth + 0.5;
    self.colorsLayer.mask = layer;
    self.colorMaskLayer = layer;
}

- (CAShapeLayer *)p_generateMaskLayer {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    
    UIBezierPath *path = nil;
    if (_type) {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.lkx_width * 0.5, self.lkx_height * 0.5)
                                              radius:MIN(self.lkx_width, self.lkx_height) / 2.5
                                          startAngle:LKX_START_ANGLE
                                            endAngle:LKX_END_ANGLE
                                           clockwise:YES];
    } else {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.lkx_width * 0.5, self.lkx_height * 0.5)
                                              radius:MIN(self.lkx_width, self.lkx_height) * 0.5
                                          startAngle:LKX_END_ANGLE
                                            endAngle:LKX_START_ANGLE
                                           clockwise:NO];
    }
    
    shapeLayer.lineWidth = _lineWidth;
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    
    return shapeLayer;
}

- (void)setPersentage:(CGFloat)persentage {
    _persentage = persentage;
    self.colorMaskLayer.strokeEnd = persentage;
    LKXMLog(@"presentage=%f", persentage);
}

@end
