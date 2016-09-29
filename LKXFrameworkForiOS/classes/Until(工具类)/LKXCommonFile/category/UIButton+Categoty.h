//
//  UIButton+Categoty.h
//  MyCategory
//
//  Created by lkx on 14-11-27.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Categoty)

/*
 * *给button添加角标
 */
- (void)addCorner;

/*
 * 给角标设置内容
 */
- (void)setCornerContent:(int)number;

@end
