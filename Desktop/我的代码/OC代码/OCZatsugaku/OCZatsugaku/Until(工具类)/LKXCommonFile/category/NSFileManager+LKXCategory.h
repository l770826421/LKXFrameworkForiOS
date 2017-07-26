//
//  NSFileManager+LKXCategory.h
//  InfoDay2017
//
//  Created by lkx on 2017/5/26.
//  Copyright © 2017年 西格美.刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (LKXCategory)

/**
 根据文件名从NSBunlde获取字典数据
 
 @param filename 文件名
 @return 字典数据
 */
- (NSDictionary *)lkx_dictionaryWithBundleFilename:(NSString *)filename;

/**
 根据文件名从NSBunlde获取数组数据
 
 @param filename 文件名
 @return 数组数据
 */
- (NSArray *)lkx_arrayWithBundleFilename:(NSString *)filename;

/**
 根据文件名从NSBunlde获取字符串数据
 
 @param filename 文件名
 @return 字符串数据
 */
- (NSString *)lkx_stringWithBundleFilename:(NSString *)filename;

/**
 根据文件名从NSBunlde获取data数据
 
 @param filename 文件名
 @return data数据
 */
- (NSData *)lkx_dataWithBundleFilename:(NSString *)filename;

@end
