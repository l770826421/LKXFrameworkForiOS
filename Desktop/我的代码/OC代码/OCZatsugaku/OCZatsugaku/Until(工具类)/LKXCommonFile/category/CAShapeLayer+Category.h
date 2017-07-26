//
//  CAShapeLayer+Category.h
//  SLShop
//
//  Created by lkx on 16/6/8.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (Category)

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
+ (instancetype)dashedLineLayerWithframe:(CGRect)frame color:(UIColor *)color lineWidth:(CGFloat)lineWidth dashLineWidth:(CGFloat)dashLineWidth dashLineSpace:(CGFloat)dashLineSpace;

@end
