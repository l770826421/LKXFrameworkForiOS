//
//  LKXSubmitLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/28.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXSubmitLoadingView.h"

@interface LKXSubmitLoadingView ()

/** 遮罩Layer */
@property(nonatomic, strong) CAShapeLayer *cycleLayer;

@end

@implementation LKXSubmitLoadingView

@synthesize loadingTintColor;
@synthesize animationDuration;
@synthesize lineWidth;
@synthesize loading;

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
    _cycleLayer = [CAShapeLayer layer];
    _cycleLayer.lineCap = kCALineCapRound;
    _cycleLayer.lineJoin = kCALineJoinRound;
    _cycleLayer.lineWidth = self.lineWidth;
    _cycleLayer.fillColor = [UIColor clearColor].CGColor;
    _cycleLayer.strokeColor = [UIColor whiteColor].CGColor;
    _cycleLayer.strokeEnd = 0;
    [self.layer addSublayer:_cycleLayer];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    _cycleLayer.frame = self.bounds;
    _cycleLayer.position = CGPointMake(self.lkx_width * 0.5, self.lkx_height * 0.5);
    _cycleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;;
}

- (CGFloat)lineWidth {
    return 4;
}

- (NSTimeInterval)animationDuration {
    return 1;
}

- (UIColor *)loadingTintColor {
    return [UIColor whiteColor];
}

/**
 * 开始动画
 * 动画原理:
 * 1. 先画一个1/4的圆弧
 * 2. 在开始旋转动画,旋转动画在圆弧动画后开始
 */
- (void)startLoading {
    self.loading = YES;
    self.alpha = 1;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0;
    strokeEndAnimation.toValue = @0.25;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.duration = self.animationDuration / 4;
    [_cycleLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    
    // 旋转动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = @0;
    rotateAnimation.toValue = @(M_PI * 2);
    rotateAnimation.repeatCount = NSIntegerMax;
    rotateAnimation.duration = self.animationDuration;
    rotateAnimation.beginTime = CACurrentMediaTime() + strokeEndAnimation.duration;
    [_cycleLayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
}

- (void)stopLoading:(void (^)())finish {
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"stokeEnd"];
    strokeEndAnimation.toValue = @1;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.duration = self.animationDuration * 3.0 / 4.0;
    [_cycleLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    
    [UIView animateWithDuration:0.3 delay:strokeEndAnimation.duration options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [_cycleLayer removeAllAnimations];
        self.loading = NO;
        if (finish) {
            finish();
        }
    }];
    
}

@end
