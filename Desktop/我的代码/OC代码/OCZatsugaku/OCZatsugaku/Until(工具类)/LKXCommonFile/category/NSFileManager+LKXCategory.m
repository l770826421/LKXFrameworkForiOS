//
//  NSFileManager+LKXCategory.m
//  InfoDay2017
//
//  Created by lkx on 2017/5/26.
//  Copyright © 2017年 西格美.刘克邪. All rights reserved.
//

#import "NSFileManager+LKXCategory.h"

@implementation NSFileManager (LKXCategory)

/**
 根据文件名从NSBunlde获取字典数据

 @param filename 文件名
 @return 字典数据
 */
- (NSDictionary *)lkx_dictionaryWithBundleFilename:(NSString *)filename {
    NSString *path = [self p_pathWithBundleFilename:filename];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return dic;
}

/**
 根据文件名从NSBunlde获取数组数据
 
 @param filename 文件名
 @return 数组数据
 */
- (NSArray *)lkx_arrayWithBundleFilename:(NSString *)filename {
    NSString *path = [self p_pathWithBundleFilename:filename];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    return array;
}

/**
 根据文件名从NSBunlde获取字符串数据
 
 @param filename 文件名
 @return 字符串数据
 */
- (NSString *)lkx_stringWithBundleFilename:(NSString *)filename {
    NSString *path = [self p_pathWithBundleFilename:filename];
    
    NSError *error = nil;
    
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        LKXMLog(@"读取字符串失败:%@", error);
        return nil;
    }
    
    return string;
}

/**
 根据文件名从NSBunlde获取data数据
 
 @param filename 文件名
 @return data数据
 */
- (NSData *)lkx_dataWithBundleFilename:(NSString *)filename {
    NSString *path = [self p_pathWithBundleFilename:filename];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    return data;
}

- (NSString *)p_pathWithBundleFilename:(NSString *)filename {
    NSAssert(![NSString isEmptyWithString:filename], @"文件名为空");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    return path;
}

@end
