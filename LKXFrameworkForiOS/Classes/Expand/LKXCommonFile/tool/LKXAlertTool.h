//
//  LKXAlertTool.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/10/20.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKXAlertTool;

typedef NS_ENUM(NSInteger, LKXAlertStyle) {
    LKXAlertStyleActionSheet = 0,
    LKXAlertStyleAlert
};

@protocol LKXAlertToolDelegate <NSObject>

@optional
- (void)alertTool:(LKXAlertTool *)alertTool didSelectedIndex:(NSInteger)index;

@end


/**
 这里集成了系统的提示选择框,但是UIAlertView和UIActionSheet的delegate只能是UIViewController及其子类,所有他们的代理只能实现在外部
 */
@interface LKXAlertTool : NSObject

/** title */
@property (nonatomic, copy) NSString *title;
/** message */
@property (nonatomic, copy) NSString *message;
/** 弹出框的类型 */
@property (nonatomic, assign) LKXAlertStyle style;
/** 各个选择的title,去后一个为cancel style,如果没有cancel style,最后一个传入nil */
@property (nonatomic, strong) NSArray *titles;
/** 显示的VC */
@property (nonatomic, weak) UIViewController *showViewController;
/** delegate */
@property (nonatomic, weak)  id<LKXAlertToolDelegate> delegate;
/** 标识符 */
@property (nonatomic, assign) NSInteger tag;

/**
 显示提示框选择框
 */
- (void)show;

@end
