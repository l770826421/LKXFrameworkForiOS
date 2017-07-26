//
//  LKXGlassesLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/29.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXGlassesLoadingView.h"

@interface LKXGlassesLoadingView ()

/** 圆点数组 */
@property(nonatomic, strong) NSMutableArray<CAShapeLayer *> *spotLayers;

@end

@implementation LKXGlassesLoadingView

@synthesize loading;
@synthesize lineWidth;
@synthesize animationDuration;
@synthesize loadingTintColor;

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

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self p_setup];
}

- (void)p_setup {
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.bounds = CGRectMake(0, 0, self.lineWidth, self.lineWidth);
        layer.path = [UIBezierPath bezierPathWithOvalInRect:layer.bounds].CGPath;
        layer.fillColor = self.loadingTintColor.CGColor;
        layer.strokeColor = self.loadingTintColor.CGColor;
        [self.spotLayers addObject:layer];
        [self.layer addSublayer:layer];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self p_updateUI];
}

- (void)p_updateUI {
    for (int i = 0; i < _spotLayers.count; i++) {
        CAShapeLayer *layer = _spotLayers[i];
        layer.position = CGPointMake(self.lkx_width / (_spotLayers.count - 1) * i, self.lkx_height * 0.5);
    }
}

#pragma mark - setter and getter
- (NSMutableArray<CAShapeLayer *> *)spotLayers {
    if (!_spotLayers) {
        _spotLayers = [NSMutableArray array];
    }
    return _spotLayers;
}

- (NSTimeInterval)animationDuration {
    return 1;
}

- (CGFloat)lineWidth {
    return 8;
}

- (UIColor *)loadingTintColor {
    return [UIColor whiteColor];
}

- (void)startLoading {
    [self p_updateUI];
    
    self.loading = YES;
    self.alpha = 1;
    
    CAShapeLayer *spotLayer0 = _spotLayers[0];
    CAShapeLayer *spotLayer1 = _spotLayers[1];
    CAShapeLayer *spotLayer2 = _spotLayers[2];
    
    CGFloat radius = self.lkx_width / (_spotLayers.count - 1) * 0.5;
    CGPoint arcCenterLeft = CGPointMake(radius, CGRectGetMidY(spotLayer0.frame));
    CGPoint arcCenterRight = CGPointMake(self.lkx_width - radius, arcCenterLeft.y);
    
    // 左边圆点向中间跳动路径
    UIBezierPath *pathToRight0 = [UIBezierPath bezierPathWithArcCenter:arcCenterLeft
                                                                radius:radius
                                                            startAngle:M_PI
                                                              endAngle:0
                                                             clockwise:YES];
    //中间圆点右有跳动路径
    UIBezierPath *pathToRight1 = [UIBezierPath bezierPathWithArcCenter:arcCenterRight
                                                                radius:radius
                                                            startAngle:M_PI
                                                              endAngle:0
                                                             clockwise:YES];
    // 运动规律:最左边的圆点先跳到中间(与中间的圆点交换)，在跳到右边(再与右边的圆点交换),然后最左边的再一次动画
    [pathToRight0 appendPath:pathToRight1];
    
    
    CAKeyframeAnimation *pathToRightAnimation0 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathToRightAnimation0.path = pathToRight0.CGPath;
    pathToRightAnimation0.calculationMode = kCAAnimationPaced;
    pathToRightAnimation0.duration = self.animationDuration;
    pathToRightAnimation0.repeatCount = NSIntegerMax;
    [spotLayer0 addAnimation:pathToRightAnimation0
                      forKey:@"pathToRightAnimation0"];
    
    // 中间的圆点向左跳动
    UIBezierPath *pathToLeft0 = [UIBezierPath bezierPathWithArcCenter:arcCenterLeft
                                                               radius:radius
                                                           startAngle:0
                                                             endAngle:M_PI
                                                            clockwise:YES];
    CAAnimationGroup *group0 = [self p_generalGroupAnimationWithPath:pathToLeft0
                                              needRemoveOnCompletion:YES
                                                           beginTime:0];
    [spotLayer1 addAnimation:group0 forKey:@"group0"];
    
    // 右边的圆点先中间跳动
    UIBezierPath *pathToLeft1 = [UIBezierPath bezierPathWithArcCenter:arcCenterRight
                                                               radius:radius
                                                           startAngle:0
                                                             endAngle:M_PI
                                                            clockwise:YES];
    CAAnimationGroup *group1 = [self p_generalGroupAnimationWithPath:pathToLeft1
                                              needRemoveOnCompletion:NO
                                                           beginTime:self.animationDuration * 0.5];
    [spotLayer2 addAnimation:group1 forKey:@"group1"];
}

/**
 动画组

 @param path 动画路径
 @param removeOnCompletion 代表动画执行完毕后就从图层上移除
 @param beginTime 开始动画时间
 @return 动画组
 */
- (CAAnimationGroup *)p_generalGroupAnimationWithPath:(UIBezierPath *)path
                               needRemoveOnCompletion:(BOOL)removeOnCompletion
                                            beginTime:(CFTimeInterval)beginTime {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.calculationMode = kCAAnimationPaced;  // 匀速,keyTimes跟timeFunctions失效
    animation.duration = self.animationDuration * 0.5;
    if (removeOnCompletion) {
        animation.fillMode = kCAFillModeForwards;   //当动画结束后,layer会一直保持着动画最后的状态
        animation.removedOnCompletion = NO;
    }
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation];
    group.duration = self.animationDuration;
    group.repeatCount = NSIntegerMax;
    if (beginTime != 0) {
        group.beginTime = CACurrentMediaTime() + beginTime;
    }
    return group;
}

- (void)stopLoading:(void (^)())finish {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.loading = NO;
        for (CAShapeLayer *layer in _spotLayers) {
            [layer removeAllAnimations];
        }
        if (finish) {
            finish();
        }
    }];
}

@end
