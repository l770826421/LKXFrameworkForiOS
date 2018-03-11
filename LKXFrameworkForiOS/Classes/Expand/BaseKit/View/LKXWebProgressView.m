//
//  LKXWebProgressView.m
//  Mobile51nb
//
//  Created by lkx on 2017/5/15.
//  Copyright © 2017年 西格美.刘克邪. All rights reserved.
//

#import "LKXWebProgressView.h"

@implementation LKXWebProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.progress = 0.0f;
        self.progressColor = [UIColor greenColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, self.progressColor.CGColor);
    CGContextSetLineWidth(ctx, self.lkx_height);
    CGContextAddRect(ctx, CGRectMake(0, 0, self.lkx_width * self.progress, self.lkx_height));
    CGContextFillPath(ctx);
}

#pragma mark - setter and getter
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    [self setNeedsDisplay];
}

@end
