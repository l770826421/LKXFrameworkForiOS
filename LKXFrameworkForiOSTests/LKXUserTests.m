//
//  LKXUserTests.m
//  LKXFrameworkForiOSTests
//
//  Created by lkx on 2017/11/15.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LKXUser.h"
#import "NSObject+LKXRuntime.h"
#import "NSString+LKXCategory.h"

@interface LKXUserTests : XCTestCase

@end

@implementation LKXUserTests

/**
 一次单元测试开始前的准备工作，可以设置全局变量
 */
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

/**
 一次单元测试结束前的销毁工作
 */
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 测试新建LKXUserModel模型
 
 
 */
- (void)testNewUser {
    [self checkUserWithDic:@{@"name" : @"zhang", @"age" : @20}];
    [self checkUserWithDic:@{@"name" : @"zhang"}];
    [self checkUserWithDic:@{@"name" : @"zhang", @"age" : @20, @"title" : @"boss"}];
    [self checkUserWithDic:@{@"name" : @"zhang", @"age" : @0, @"title" : @"boss"}];
    [self checkUserWithDic:@{@"name" : @"zhang", @"age" : @130, @"title" : @"boss"}];
    /*
     失败测试
    // 姓名不能为空
    [self checkUserWithDic:@{@"name" : @""}];
    // 年龄必须在0~130岁之间
    [self checkUserWithDic:@{@"name" : @"zhang", @"age" : @(-20), @"title" : @"boss"}];
    [self checkUserWithDic:@{@"name" : @"zhang", @"age" : @200, @"title" : @"boss"}];
     */
}

- (void)checkUserWithDic:(NSDictionary *)dic {
    LKXUser *user = [LKXUser lkx_objectWithDictionary:dic];
    NSLog(@"user = %@", user);
    
    // 名称不能为空
    NSAssert(![NSString lkx_isNullWithString:user.name], @"名称不能为空");
    // 年龄必须在0~130岁之间
    NSAssert(user.age >= 0 && user.age <= 130, @"年龄必须在0~130岁之间");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLoadUserAsync {
    [LKXUser loadUserWithDictionary:@{@"name" : @"zhang", @"age" : @130, @"title" : @"boss"} completion:^(LKXUser *user) {
        NSLog(@"姓名: %@", user.name);
    }];
}

/**
 性能测试
 
 相同的代码执行十次，统计执行时间，计算平均值。
 
 性能测试代码写好后，可以随时测试。
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 将要测量执行时间的代码放在此处。
        
        // 1万条及以上就会出现性能问题
        for (int i = 0; i < 1000; i++) {
            [self checkUserWithDic:@{@"name" : @"zhang", @"age" : @130, @"title" : @"boss"}];
        }
    }];
}

@end
