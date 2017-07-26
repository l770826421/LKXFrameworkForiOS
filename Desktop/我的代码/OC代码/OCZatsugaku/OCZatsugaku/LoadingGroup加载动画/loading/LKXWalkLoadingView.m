//
//  LKXWalkLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/29.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXWalkLoadingView.h"

@interface LKXWalkLoadingView ()

/** 圆点数组 */
@property(nonatomic, strong) NSMutableArray<CAShapeLayer *> *spotLayers;

@end

@implementation LKXWalkLoadingView

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

- (void)awakeFromNib {
    [super awakeFromNib];
    [self p_setup];
}

- (void)p_setup {
    for (int i = 0; i < 4; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.bounds = CGRectMake(0, 0, self.lineWidth, self.lineWidth);
        layer.path = [UIBezierPath bezierPathWithOvalInRect:layer.bounds].CGPath;
        layer.fillColor = self.loadingTintColor.CGColor;
        layer.strokeColor = self.loadingTintColor.CGColor;
        
        [self.layer addSublayer:layer];
        [self.spotLayers addObject:layer];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self p_updateUI];
}

- (void)p_updateUI {
    NSInteger count = _spotLayers.count;
    for (int i = 0; i < count; i++) {
        CAShapeLayer *layer = _spotLayers[i];
        layer.position = CGPointMake(self.lkx_width / (count - 1) * i, self.lkx_height * 0.5);
    }
}

#pragma mark - setter and getter 
- (NSMutableArray<CAShapeLayer *> *)spotLayers {
    if (!_spotLayers) {
        _spotLayers = [NSMutableArray array];
    }
    return _spotLayers;
}

- (CGFloat)lineWidth {
    return 8;
}

- (UIColor *)loadingTintColor {
    return [UIColor whiteColor];
}

- (NSTimeInterval)animationDuration {
    return 0.5;
}


#pragma mark - 动画
- (void)startLoading {
    [self p_updateUI];
    self.loading = YES;
    self.alpha = 1;
    
    CAShapeLayer *layer0 = _spotLayers[0];
    
    // 最左边圆点的圆弧运动动画
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.lkx_width * 0.5, self.lkx_height * 0.5) radius:self.lkx_width * 0.5 startAngle:M_PI endAngle:0 clockwise:YES];
    CAKeyframeAnimation *arcAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    arcAnimation.path = arcPath.CGPath;
    arcAnimation.calculationMode = kCAAnimationPaced;
//    arcAnimation.fillMode = kCAFillModeForwards;
    arcAnimation.duration = self.animationDuration;
    arcAnimation.repeatCount = NSIntegerMax;
    [layer0 addAnimation:arcAnimation forKey:@"arcAnimation"];
    
    NSInteger count = _spotLayers.count;
    for (int i = 1; i < count; i++) {
        CAShapeLayer *spotLayer = _spotLayers[i];
        CABasicAnimation *lineAnniamtion = [CABasicAnimation animationWithKeyPath:@"position.x"];
        lineAnniamtion.toValue = @(spotLayer.position.x - self.lkx_width / (count - 1));
//        lineAnniamtion.fillMode = kCAFillModeForwards;
        lineAnniamtion.duration = self.animationDuration;
        lineAnniamtion.repeatCount = NSIntegerMax;
        [spotLayer addAnimation:lineAnniamtion forKey:@"lineAnniamtion"];
    }
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
