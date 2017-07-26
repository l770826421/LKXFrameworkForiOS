//
//  LKXZhiHuLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/30.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXZhiHuLoadingView.h"

@interface LKXZhiHuLoadingView ()

/** 遮罩弧线 */
@property(nonatomic, strong) CAShapeLayer *cycleLayer;

@end

@implementation LKXZhiHuLoadingView

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
    _cycleLayer = [CAShapeLayer layer];
    _cycleLayer.lineCap = kCALineCapRound;
    _cycleLayer.lineJoin = kCALineJoinRound;
    _cycleLayer.lineWidth = self.lineWidth;
    _cycleLayer.fillColor = [UIColor clearColor].CGColor;
    _cycleLayer.strokeColor = self.loadingTintColor.CGColor;
    _cycleLayer.strokeEnd = 0;
    [self.layer addSublayer:_cycleLayer];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self p_updateUI];
}

- (void)p_updateUI {
    _cycleLayer.frame = self.bounds;
    _cycleLayer.path = [UIBezierPath bezierPathWithOvalInRect:_cycleLayer.bounds].CGPath;
}

#pragma mark - setter and getter
- (NSTimeInterval)animationDuration {
    return 1;
}

- (CGFloat)lineWidth {
    return 4;
}

- (UIColor *)loadingTintColor {
    return [UIColor whiteColor];
}

#pragma mark - Other
- (void)startLoading {
    self.loading = YES;
    self.alpha = 1;
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @1;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0;
    strokeEndAnimation.toValue = @1;
    
    CAAnimationGroup *strokeAnimationGroup = [CAAnimationGroup animation];
    strokeAnimationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    strokeAnimationGroup.duration = self.animationDuration;
    strokeAnimationGroup.repeatCount = NSIntegerMax;
    [_cycleLayer addAnimation:strokeAnimationGroup forKey:@"strokeAnimationGroup"];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.repeatCount = self.animationDuration;
    [_cycleLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading:(void (^)())finish {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.loading = NO;
        [self.cycleLayer removeAllAnimations];
        if (finish) {
            finish();
        }
    }];
}

@end
