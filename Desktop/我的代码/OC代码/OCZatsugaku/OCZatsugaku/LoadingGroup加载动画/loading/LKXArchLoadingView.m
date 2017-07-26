//
//  LKXArchLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/30.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXArchLoadingView.h"

@interface LKXArchLoadingView ()

/** 圆点数组 */
@property(nonatomic, strong) NSMutableArray<CAShapeLayer *> *spotLayers;

@end

@implementation LKXArchLoadingView

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
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        layer.lineWidth = self.lineWidth;   // 设置layer的大小
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = self.loadingTintColor.CGColor;
        layer.strokeEnd = 0.000001;
        
        [self.layer addSublayer:layer];
        [self.spotLayers addObject:layer];
        
        
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOffset = CGSizeMake(10, 10);
        layer.shadowOpacity = 0.2;
        layer.shadowRadius = 10;
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
        CGFloat width = self.lkx_width * (count - i) * 0.6;
        // 设置layer在父layer中的圆点位置，因为锚点是(0.5, 0.5),这里是设置为(0, 0)
        layer.bounds = CGRectMake(0, 0, width, width);
        // 在设置layer在父layer的位置
        layer.position = CGPointMake(self.lkx_width * 1.1, self.lkx_height * 0.5);
        layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width * 0.5 - self.lkx_width * 0.3, width * 0.5)
                                                    radius:width * 0.25
                                                startAngle:M_PI
                                                  endAngle:M_PI * 2
                                                 clockwise:true].CGPath;
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

#pragma mark - Other

/**
 * 动画原理
 * 1.第一步进行水平移动
 * 2.弧形运动strokeStart --> strokeEnd
 * 3.strokerStart:-1->1 strokeEnd:0->1 在相同时间就会有一个弧形产生
 */
- (void)startLoading {
    self.loading = YES;
    self.alpha = 1;
    
    for (int i = 0; i < _spotLayers.count; i++) {
        CALayer *layer = _spotLayers[i];
        
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        transformAnimation.fromValue = @(self.lkx_width * 1.1);
        transformAnimation.toValue =@(self.lkx_width * 0.5);
        transformAnimation.duration = self.animationDuration;
        transformAnimation.fillMode = kCAFillModeForwards;
        transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transformAnimation.removedOnCompletion = NO;
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0;
        strokeEndAnimation.toValue = @1;
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @(-1);
        strokeStartAnimation.toValue = @1;
        
        CAAnimationGroup *strokeAnimationGroup = [CAAnimationGroup animation];
        strokeAnimationGroup.duration = (self.animationDuration - (_spotLayers.count - 1) * self.animationDuration * 0.1) * 0.8;
        strokeAnimationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        strokeAnimationGroup.fillMode = kCAFillModeForwards;
        strokeAnimationGroup.removedOnCompletion = NO;
        strokeAnimationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = self.animationDuration ;
        group.repeatCount = NSIntegerMax;
        group.animations = @[transformAnimation, strokeAnimationGroup];
        
        [layer addAnimation:group forKey:@"group"];
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
