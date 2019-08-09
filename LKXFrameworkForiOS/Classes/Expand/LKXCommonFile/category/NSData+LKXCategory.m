//
//  NSData+LKXCategory.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 14-12-22.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "NSData+LKXCategory.h"

@implementation NSData (LKXCategory)

/*
 * 将图片转为NSData
 * @parameter url  图片
 */
+(NSData *)lkx_imageDataWithImage:(UIImage *)image
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

/**
 转base64字符串
 
 @return base64字符串
 */
- (NSString *)lkx_toBase64String {
    NSData *base64Data = [self base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *base64String = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return base64String;
}

@end
