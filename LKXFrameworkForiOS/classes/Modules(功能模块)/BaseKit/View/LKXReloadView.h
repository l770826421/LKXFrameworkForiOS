//
//  LKXReloadView.m
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKXReloadView;

@protocol LKXReloadViewDelegate <NSObject>

@optional
- (void)reloadViewDidTouchUpInside:(LKXReloadView *)reloadView;

@end

/**
 *  @author 刘克邪
 *
 *  @brief  重新加载View
 */
@interface LKXReloadView : UIView

@property (nonatomic, weak) id<LKXReloadViewDelegate> delegate;

/** 是否是网络错误 */
@property (nonatomic, assign, setter=isNetWorkError:) BOOL isNetWorkError;

@end
