//
//  NSData+LKXCategory.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 14-12-22.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSData (LKXCategory)

/*
 * 将图片转为NSData
 * @parameter url  图片
 */
+(NSData *)lkx_imageDataWithImage:(UIImage *)image;

/**
 转base64字符串

 @return base64字符串
 */
- (NSString *)lkx_toBase64String;

@end
