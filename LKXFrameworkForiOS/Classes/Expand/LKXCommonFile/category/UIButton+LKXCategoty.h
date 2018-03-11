//
//  UIButton+LKXCategoty.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 14-11-27.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LKXCategoty)

/*
 * *给button添加角标
 */
- (void)lkx_addCorner;

/*
 * 给角标设置内容
 */
- (void)lkx_setCornerContent:(int)number;

@end
