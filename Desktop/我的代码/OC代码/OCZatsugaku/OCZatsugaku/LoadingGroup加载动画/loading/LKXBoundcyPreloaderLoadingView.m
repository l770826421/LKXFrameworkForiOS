//
//  LKXBoundcyPreloaderLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/30.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXBoundcyPreloaderLoadingView.h"

@interface LKXBoundcyPreloaderLoadingView ()

/** 圆点遮罩 */
@property(nonatomic, strong) CAShapeLayer *spotLayer;
/** 复制层 */
@property(nonatomic, strong) CAReplicatorLayer *replicatorLayer;

@end

@implementation LKXBoundcyPreloaderLoadingView

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
    _spotLayer = [CAShapeLayer layer];
    _spotLayer.frame = CGRectMake(0, 0, self.lineWidth, self.lineWidth);
    _spotLayer.path = [UIBezierPath bezierPathWithOvalInRect:_spotLayer.bounds].CGPath;
    _spotLayer.lineCap = kCALineCapRound;
    _spotLayer.lineJoin = kCALineCapRound;
    _spotLayer.lineWidth = self.lineWidth;
    _spotLayer.fillColor = self.loadingTintColor.CGColor;
    _spotLayer.strokeColor = self.loadingTintColor.CGColor;
    
    _replicatorLayer = [CAReplicatorLayer layer];
    [_replicatorLayer addSublayer:_spotLayer];
    _replicatorLayer.instanceCount = 3;
    _replicatorLayer.instanceDelay = self.animationDuration / 5;
    
    [self.layer addSublayer:_replicatorLayer];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self p_updateUI];
}

- (void)p_updateUI {
    _spotLayer.frame = CGRectMake(self.lineWidth * 0.5, (self.lkx_height - self.lineWidth) * 0.5, self.lineWidth, self.lineWidth);
    _replicatorLayer.frame = self.bounds;
    _replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.lkx_width / _replicatorLayer.instanceCount, 0, 0);
}

#pragma mark - setter and getter
- (NSTimeInterval)animationDuration {
    return 0.5;
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
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
    // 上下动画的位置
    CGFloat centerY = self.lkx_height * 0.5;
    CGFloat downY = centerY + 15;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.beginTime = CACurrentMediaTime() + 0.5;
    positionAnimation.values = @[@(centerY), @(downY), @(centerY), @(downY)];
    positionAnimation.keyTimes = @[@0, @0.33, @0.63, @1];
    positionAnimation.repeatCount = NSIntegerMax;
    positionAnimation.duration = self.animationDuration + 0.4;
    [_spotLayer addAnimation:positionAnimation forKey:@"positionAnimation"];
}

- (void)stopLoading:(void (^)())finish {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.loading = YES;
        [self.spotLayer removeAllAnimations];
        if (finish) {
            finish();
        }
    }];
}

@end
