//
//  NSObject+LKXRuntime.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/11/9.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "NSObject+LKXRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (LKXRuntime)

char const *kPropertyListKey = "kPropertyListKey";
/**
 获取类的属性

 @return 属性名称数组
 */
+ (NSArray *)lkx_propertyList {
    NSArray *ptyList = objc_getAssociatedObject(self, kPropertyListKey);
    if (ptyList != nil) {
        return ptyList;
    }
    
    unsigned int count = 0;
    /**
     * 调用运行时方法,取得类的属性列表
     * Ivar 成员变量
     * Method 方法
     * Property 属性
     * Protocol 协议
     *
     * 参数
     * 1.要获取的类
     * 2.类属性的个数指针
     *
     * 返回值
     * 所有属性的数组,C 语言中,数组的名字,就是指向第一个元素的地址
     */
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    
    NSMutableArray *properNameList = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // 1.从数组中取得属性
        // C 语言的结构体指针,通常不用"*"
        objc_property_t pty = propertyList[i];
        
        // 2.从pty中获得属性的名称
        char const *cName = property_getName(pty);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        // 3.属性名称添加到数组
        [properNameList addObject:name];
    }
    
    free(propertyList);
    
    LKXMLog(@"属性名数组:\n%@", properNameList);
    objc_setAssociatedObject(self, kPropertyListKey, properNameList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return properNameList.copy;
}

/**
 给定一个字典,创建self类对应的对象

 @param dic 字典
 @return 对象
 */
+ (instancetype)lkx_objectWithDictionary:(NSDictionary *)dic {
    id object = [[self alloc] init];
    
    NSArray *propertyList = [self lkx_propertyList];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([propertyList containsObject:key]) {
            [object setValue:obj forKey:key];
        }
    }];
    
    return object;
}

@end
