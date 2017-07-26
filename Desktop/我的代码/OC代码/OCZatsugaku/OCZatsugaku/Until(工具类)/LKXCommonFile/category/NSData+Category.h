//
//  NSData+Category.h
//  MyCategory
//
//  Created by lkx on 14-12-22.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Category)

/*
 * 将图片转为NSData
 * @parameter url  图片
 */
+(NSData *)imageDataWithImage:(UIImage *)image;

@end
