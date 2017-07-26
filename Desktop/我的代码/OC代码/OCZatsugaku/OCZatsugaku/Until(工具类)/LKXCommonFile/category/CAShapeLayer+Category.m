//
//  CAShapeLayer+Category.m
//  SLShop
//
//  Created by lkx on 16/6/8.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "CAShapeLayer+Category.h"

@implementation CAShapeLayer (Category)

/**
 *  @author 刘克邪
 *
 *  @brief  绘制线宽
 *
 *  @param frame         虚线的frame
 *  @param color         虚线颜色
 *  @param lineWidth     虚线区域高度
 *  @param dashLineWidth 虚线的每条线线宽
 *  @param dashLineSpace 虚线的每条线间距
 *
 */
+ (instancetype)dashedLineLayerWithframe:(CGRect)frame color:(UIColor *)color lineWidth:(CGFloat)lineWidth dashLineWidth:(CGFloat)dashLineWidth dashLineSpace:(CGFloat)dashLineSpace {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFrame:frame];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[color CGColor]];
    [shapeLayer setLineWidth:lineWidth];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // dashLineWidth线宽 dashLineSpace间距
    [shapeLayer setLineDashPattern:@[@(dashLineWidth), @(dashLineSpace)]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = frame.size.height * 0.5;
    CGPathMoveToPoint(path, NULL, 0, y);
    CGPathAddLineToPoint(path, NULL, frame.size.width, y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    return shapeLayer;
}

@end
