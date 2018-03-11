//
//  LKXWebProgressView.h
//  Mobile51nb
//
//  Created by lkx on 2017/5/15.
//  Copyright © 2017年 西格美.刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 web进度条
 */
@interface LKXWebProgressView : UIView

/**
 进度颜色
 */
@property (nonatomic, strong) UIColor *progressColor;
/**
 进度
 */
@property(nonatomic, assign) CGFloat progress;

@end
