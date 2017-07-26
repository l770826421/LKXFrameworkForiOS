//
//  LKXPacManLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/7/3.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXPacManLoadingView.h"

@interface LKXPacManLoadingView ()

/** 贪吃豆layer数组 */
@property(nonatomic, strong) NSMutableArray *pacManLayers;
/** 绘图路径 */
@property(nonatomic, strong) NSArray<UIBezierPath *> *cyclePaths;

@end

@implementation LKXPacManLoadingView

@synthesize loading;
@synthesize loadingTintColor;
@synthesize lineWidth;
@synthesize animationDuration;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self p_setup];
}

- (void)p_setup {
    for (int i = 0; i < 4; i++) {
        CAShapeLayer *cycleLayer = [CAShapeLayer layer];
        cycleLayer.frame = CGRectZero;
        cycleLayer.cornerRadius = self.lineWidth * 0.5;
        cycleLayer.masksToBounds = YES;
        cycleLayer.fillColor = [UIColor clearColor].CGColor;
        cycleLayer.strokeColor = self.loadingTintColor.CGColor;
        cycleLayer.lineWidth = self.lineWidth;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.lineWidth, self.lineWidth)];
        cycleLayer.path = path.CGPath;
        cycleLayer.strokeStart = 0.25;
        cycleLayer.strokeEnd = 1;
        cycleLayer.transform = CATransform3DMakeRotation(M_PI_2 * i, 0, 0, 1);
        
        [self.layer addSublayer:cycleLayer];
        [self.pacManLayers addObject:cycleLayer];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self p_updateUI];
}

- (void)p_updateUI {
    CGFloat selfWidthSubCycleWidth = self.lkx_width - self.lineWidth;
    CGPoint arcCenter = CGPointMake(self.lkx_width * 0.5, self.lkx_height * 0.5);
    CGFloat halfCycelWidth = self.lineWidth * 0.5;
    CGPoint leftConerPoint = CGPointMake(halfCycelWidth, halfCycelWidth);
    CGFloat radius = sqrt(pow(arcCenter.x - leftConerPoint.x, 2) + pow(arcCenter.y - leftConerPoint.y, 2));
    
    CAShapeLayer *cycleLayer0 = _pacManLayers[0];
    cycleLayer0.frame = CGRectMake(0, 0, self.lineWidth, self.lineWidth);
    
    CAShapeLayer *cycleLayer1 = _pacManLayers[1];
    cycleLayer1.frame = CGRectMake(selfWidthSubCycleWidth, 0, self.lineWidth, self.lineWidth);
    
    CAShapeLayer *cycleLayer2 = _pacManLayers[2];
    cycleLayer2.frame = CGRectMake(selfWidthSubCycleWidth, selfWidthSubCycleWidth, self.lineWidth, self.lineWidth);
    
    CAShapeLayer *cycleLayer3 = _pacManLayers[3];
    cycleLayer3.frame = CGRectMake(0, selfWidthSubCycleWidth, self.lineWidth, self.lineWidth);
    
    CGPoint controlPoint0 = CGPointMake(arcCenter.x, arcCenter.y - radius);
    CGPoint controlPoint1 = CGPointMake(arcCenter.x + radius, arcCenter.y);
    CGPoint controlPoint2 = CGPointMake(arcCenter.x, arcCenter.y + radius);
    CGPoint controlPoint3 = CGPointMake(arcCenter.x - radius, arcCenter.y);
    
    UIBezierPath *path0 = [self p_addQuadCurveWithFromPoint:cycleLayer0.position toPoint:cycleLayer1.position controlPoint:controlPoint0];
    UIBezierPath *path1 = [self p_addQuadCurveWithFromPoint:cycleLayer1.position toPoint:cycleLayer2.position controlPoint:controlPoint1];
    UIBezierPath *path2 = [self p_addQuadCurveWithFromPoint:cycleLayer2.position toPoint:cycleLayer3.position controlPoint:controlPoint2];
    UIBezierPath *path3 = [self p_addQuadCurveWithFromPoint:cycleLayer3.position toPoint:cycleLayer0.position controlPoint:controlPoint3];
    _cyclePaths = @[path0, path1, path2, path3];
}

/**
 贝塞尔曲线

 @param fromPoint 起点
 @param toPoint 终点
 @param controlPoint 控制点
 @return 贝塞尔曲线
 */
- (UIBezierPath *)p_addQuadCurveWithFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint controlPoint:(CGPoint)controlPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:fromPoint];
    [path addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    return path;
}


#pragma mark - setter and getter
- (NSMutableArray *)pacManLayers {
    if (!_pacManLayers) {
        _pacManLayers = [NSMutableArray array];
    }
    return _pacManLayers;
}

- (NSTimeInterval)animationDuration {
    return 1.5;
}

- (CGFloat)lineWidth {
    return 22;
}

- (UIColor *)loadingTintColor {
    return [UIColor whiteColor];
}

#pragma mark - Other
- (void)startLoading {
    [self p_updateUI];
    self.loading = YES;
    self.alpha = 1;
    
    for (int i = 0; i < _pacManLayers.count; i++) {
        CAShapeLayer *layer = _pacManLayers[i];
        UIBezierPath *path = _cyclePaths[i];
        
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotateAnimation.fromValue = @(M_PI_2 * i);
        rotateAnimation.toValue = @(M_PI_2 * i + (-M_PI_2 * 3));
        rotateAnimation.duration = self.animationDuration - 0.2;
        
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.path = path.CGPath;
        positionAnimation.calculationMode = kCAAnimationPaced;
        positionAnimation.duration = self.animationDuration - 0.2;
        
        CAAnimationGroup *groups = [CAAnimationGroup animation];
        groups.duration = self.animationDuration;
        groups.repeatCount = NSIntegerMax;
        groups.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        groups.animations = @[positionAnimation, rotateAnimation];
        
        [layer addAnimation:groups forKey:@"groups"];
    }
}

- (void)stopLoading:(void (^)())finish {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.loading = NO;
        for (CAShapeLayer *layer in _pacManLayers) {
            [layer removeAllAnimations];
        }
        
        if (finish) {
            finish();
        }
    }];
}

@end
