//
//  NSArray+LKXCategory.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 15-2-4.
//  Copyright (c) 2015年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LKXCategory)

/*
 * 数组是否包含某个字符串
 */
+ (BOOL)lkx_hasStringWithArray:(NSArray *)arr string:(NSString *)src;

@end
