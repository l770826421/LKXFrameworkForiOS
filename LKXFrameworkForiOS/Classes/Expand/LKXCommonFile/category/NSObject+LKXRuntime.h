//
//  NSObject+LKXRuntime.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/11/9.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LKXRuntime)

/**
 获取类的属性
 
 @return 属性名称数组
 */
+ (NSArray *)lkx_propertyList;

/**
 给定一个字典,创建self类对应的对象
 
 @param dic 字典
 @return 对象
 */
+ (instancetype)lkx_objectWithDictionary:(NSDictionary *)dic;

@end
