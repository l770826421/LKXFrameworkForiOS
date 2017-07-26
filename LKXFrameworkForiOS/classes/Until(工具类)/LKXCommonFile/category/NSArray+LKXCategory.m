//
//  NSArray+LKXCategory.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 15-2-4.
//  Copyright (c) 2015年 cnmobi. All rights reserved.
//

#import "NSArray+LKXCategory.h"

@implementation NSArray (LKXCategory)

/*
 * 数组是否包含某个字符串
 */
+ (BOOL)lkx_hasStringWithArray:(NSArray *)arr string:(NSString *)src
{
    BOOL isHas = NO;
    for (NSString *string in arr)
    {
        if ([string isEqualToString:src])
        {
            isHas = YES;
            return isHas;
        }
    }
    
    return isHas;
}

@end
