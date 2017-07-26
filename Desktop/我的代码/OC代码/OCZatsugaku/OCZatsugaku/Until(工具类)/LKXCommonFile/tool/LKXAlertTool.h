//
//  LKXAlertTool.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/10/20.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKXAlertTool;

@protocol LKXAlertToolDelegate <NSObject>

@optional
- (void)alertTool:(LKXAlertTool * _Nonnull)alertTool didSelectedIndex:(NSInteger)index;

@end


/**
 这里集成了系统的提示选择框,但是UIAlertView和UIActionSheet的delegate只能是UIViewController及其子类,所有他们的代理只能实现在外部
 */
@interface LKXAlertTool : NSObject

/** title */
@property (nonatomic, copy) NSString * _Nullable title;
/** message */
@property (nonatomic, copy) NSString * _Nullable message;
/** 弹出框的类型 */
@property (nonatomic, assign) UIAlertControllerStyle style;
/** 各个选择的title */
@property (nonatomic, strong) NSArray * _Nullable titles;
/** 显示的VC */
@property (nonatomic, strong) UIViewController * _Nonnull  showViewController;
/** delegate */
@property (nonatomic, weak)   _Nullable id<LKXAlertToolDelegate> delegate;

/**
 显示提示框选择框
 */
- (void)show;

@end
