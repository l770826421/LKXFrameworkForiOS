//
//  SingletonMacro.h
//  malama_ca
//
//  Created by Developer on 15/4/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

//.h
#define single_interface(class) \
+ (class *)shared##class;

//.m
#define single_implementation(class) \
static class *_instance; \
    \
+ (class *)shared##class \
{ \
    if(_instance == nil) \
    { \
        _instance = [[self alloc] init]; \
    } \
    return _instance; \
} \
    \
+ (id)allocWithZone:(NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
}

