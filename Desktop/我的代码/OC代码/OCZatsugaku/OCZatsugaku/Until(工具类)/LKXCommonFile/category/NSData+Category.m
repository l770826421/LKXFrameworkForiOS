//
//  NSData+Category.m
//  MyCategory
//
//  Created by lkx on 14-12-22.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "NSData+category.h"

@implementation NSData (Category)

/*
 * 将图片转为NSData
 * @parameter url  图片
 */
+(NSData *)imageDataWithImage:(UIImage *)image
{
    NSData *data;
    if (UIImagePNGRepresentation(image))
    {
        data = UIImagePNGRepresentation(image);
    }
    else
    {
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    return data;
}

@end
