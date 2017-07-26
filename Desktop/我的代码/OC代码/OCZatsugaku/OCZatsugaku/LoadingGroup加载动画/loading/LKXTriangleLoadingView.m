//
//  LKXTriangleLoadingView.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/30.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXTriangleLoadingView.h"

@interface LKXTriangleLoadingView ()

/** 遮罩数组 */
@property(nonatomic, strong) NSMutableArray<CAShapeLayer*> *spotLayers;
/** 顶部坐标 */
@property(nonatomic, assign) CGPoint topPoint;
/** 左边坐标 */
@property(nonatomic, assign) CGPoint leftPoint;
/** 右边坐标 */
@property(nonatomic, assign) CGPoint rightPoint;

/** 三个顶点的坐标数组 */
@property(nonatomic, strong) NSArray *points;

@end

@implementation LKXTriangleLoadingView

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
    CGFloat topPadding = self.lkx_height / 8 + self.lineWidth * 0.5;
    _topPoint = CGPointMake(self.lkx_height * 0.5, topPadding);
    
    CGFloat leftPadding = self.lkx_height * 0.5 - sqrt(3) * self.lkx_height * 0.25;
    _leftPoint = CGPointMake(leftPadding, self.lkx_height * 3 / 4 + topPadding);
    
    _rightPoint = CGPointMake(self.lkx_height - 2 * leftPadding, _leftPoint.y);
    
    _points = @[[NSValue valueWithCGPoint:_leftPoint], [NSValue valueWithCGPoint:_topPoint], [NSValue valueWithCGPoint:_rightPoint]];
    
    for (int i = 0; i < _points.count; i++) {
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
    for (int i = 0; i < _spotLayers.count; i++) {
        CAShapeLayer *layer = _spotLayers[i];
        layer.position = [_points[i] CGPointValue];
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
    return 0.7;
}

- (CGFloat)lineWidth {
    return 8;
}

- (UIColor *)loadingTintColor {
    return [UIColor whiteColor];
}

#pragma mark - Other
- (void)startLoading {
    [self p_updateUI];
    self.loading = YES;
    self.alpha = 1;
    
    NSArray *topPoints = @[[NSValue valueWithCGPoint:_topPoint], [NSValue valueWithCGPoint:_rightPoint], [NSValue valueWithCGPoint:_leftPoint]];
    
    for (int i = 0; i < _points.count; i++) {
        CAShapeLayer *layer = _spotLayers[i];
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.toValue = topPoints[i];
        positionAnimation.duration = self.animationDuration;
        positionAnimation.repeatCount = NSIntegerMax;
        [layer addAnimation:positionAnimation
                     forKey:@"positionAnimation"];
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
