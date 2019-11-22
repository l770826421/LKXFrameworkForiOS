//
//  LKXUser.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
#import "LKXUserExports.h"

@interface LKXUser : NSObject <MJCoding, NSCopying, LKXUserExports>

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

/** 昵称 */
@property(nonatomic, copy) NSString *nickname;

/** synchronized测试 */
@property(nonatomic, copy) NSString *sync;

- (void)run;
- (void)eat;

- (instancetype)run1;
- (instancetype)eat1;

- (LKXUser * (^)(void))run2;
- (LKXUser * (^)(void))eat2;

- (LKXUser * (^)(double distance))run3;
- (LKXUser * (^)(NSString *food))eat3;

@end
