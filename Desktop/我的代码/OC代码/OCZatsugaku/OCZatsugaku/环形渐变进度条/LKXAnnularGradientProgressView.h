//
//  LKXAnnularGradientProgressView.h
//  OCZatsugaku
//
//  Created by lkx on 2017/6/26.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 进度条方向

 - LKXClockWiseTypeYES: 顺时钟
 - LKXClockWiseTypeNO: 逆时钟
 */
typedef NS_ENUM(NSInteger, LKXClockWiseType) {
    LKXClockWiseTypeYES,
    LKXClockWiseTypeNO
};

/**
 环形渐变进度条
 */
@interface LKXAnnularGradientProgressView : UIView

/**
 进度条方向
 */
@property(nonatomic, assign) LKXClockWiseType type;
/**
 线宽
 */
@property(nonatomic, assign) CGFloat lineWidth;
/** 进度条背景颜色 */
@property(nonatomic, strong) UIColor *progressBackgroundColor;
/** 百分比 */
@property(nonatomic, assign)  CGFloat persentage;

@end
