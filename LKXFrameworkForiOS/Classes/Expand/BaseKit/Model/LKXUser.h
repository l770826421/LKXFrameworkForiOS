//
//  LKXUser.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface LKXUser : NSObject <MJCoding>

/**
 异步初始化LKXUser
 
 @param dic 数据源字典
 @param completion 返回block
 */
+ (void)loadUserWithDictionary:(NSDictionary *)dic completion:(void (^)(LKXUser *user))completion;

/** 姓名 */
@property(nonatomic, copy) NSString *name;
/** 年龄 */
@property(nonatomic, assign) NSUInteger age;
/** 身高 */
@property(nonatomic, assign) NSUInteger hight;

- (void)run;
- (void)eat;

- (instancetype)run1;
- (instancetype)eat1;

- (LKXUser * (^)())run2;
- (LKXUser * (^)())eat2;

- (LKXUser * (^)(double distance))run3;
- (LKXUser * (^)(NSString *food))eat3;

@end
