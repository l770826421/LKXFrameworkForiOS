//
//  LKXRequestManager.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/28.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXRequestManager.h"
#import "AFNetWorkingTool.h"

@interface LKXRequestManager ()

/** AFNetWorkingTool工具类 */
@property (nonatomic, strong) AFNetWorkingTool *afNetworkingTool;

@end

@implementation LKXRequestManager

/**
 *  @author 刘克邪
 *
 *  @brief  实现了LKXRequestManager的类单例创建
 *
 *  在分配空间的时候就实现单例初始化,实现了线程单例安全
 *
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static LKXRequestManager *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.afNetworkingTool = [AFNetWorkingTool shareAFNetWorkingTool];
    }
    return self;
}

/**
 *  @author 刘克邪
 *
 *  @brief  每一个单例必须以share开头
 *
 */
+ (instancetype)shareRequestManager {
    return [[self alloc] init];
}

@end
