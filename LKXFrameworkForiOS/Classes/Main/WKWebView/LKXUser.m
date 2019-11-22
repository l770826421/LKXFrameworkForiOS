//
//  LKXUser.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/27.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXUser.h"
#import "NSObject+LKXRuntime.h"

@implementation LKXUser

MJCodingImplementation

- (id)copyWithZone:(NSZone *)zone {
    LKXUser *user = [[LKXUser alloc] init];
    user.age = self.age;
    user.name = self.name;
    user.hight = self.hight;
    user.nickname = self.nickname;
    return user;
}

/**
 异步初始化LKXUser
 
 @param dic 数据源字典
 @param completion 返回block
 */
+ (void)loadUserWithDictionary:(NSDictionary *)dic completion:(void (^)(LKXUser *user))completion {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        LKXUser *user = [LKXUser lkx_objectWithDictionary:dic];
        if (completion) {
            completion(user);
        }
    });
}

@synthesize nickname = _nickname;
- (void)setNickname:(NSString *)nickname {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLock *lock = [[NSLock alloc] init];
//        LKXMLog(@"tryLock: %d, lockBeforeDate : %d", [lock tryLock], [lock lockBeforeDate:[NSDate date]]);
        if ([lock tryLock]) {   // 尝试获取锁
            [lock unlock];
        }
        
        if ([lock lockBeforeDate:[NSDate date]]) {  // 在设定的时间里获取锁
            [lock unlock];
        }
        [lock lock];
        LKXMLog(@"set nickname: %f", CACurrentMediaTime());
        sleep(1);
        self->_nickname = nickname;
        LKXMLog(@"set %@", nickname);
        LKXMLog(@"seted nickname: %f", CACurrentMediaTime());
        [lock unlock];
    });
}

- (NSString *)nickname {
    LKXMLog(@"get nickname: %f", CACurrentMediaTime());
    return _nickname;
}

@synthesize sync = _sync;
- (void)setSync:(NSString *)sync {
    @synchronized(sync) {
        dispatch_async(dispatch_get_main_queue(), ^{
            LKXMLog(@"set sync: %f", CACurrentMediaTime());
            sleep(1);
            self->_sync = sync;
            LKXMLog(@"set %@", sync);
            LKXMLog(@"seted sync: %f", CACurrentMediaTime());
        });
    }
}

- (NSString *)sync {
    LKXMLog(@"get sync: %f", CACurrentMediaTime());
    return _sync;
}

- (NSString *)description {
    NSArray *propertyList = @[@"name", @"age", @"hight"];
    
    return [NSString stringWithFormat:@"<%p, %@>, %@", self, [self class], [self dictionaryWithValuesForKeys:propertyList].description];
}

- (void)run {
    LKXMLog(@"%s", __FUNCTION__);
}

- (void)eat {
    LKXMLog(@"%s ", __FUNCTION__);
}

- (instancetype)run1 {
    LKXMLog(@"%s", __FUNCTION__);
    return self;
}

- (instancetype)eat1 {
    LKXMLog(@"%s", __FUNCTION__);
    return self;
}

- (LKXUser * (^)(void))run2 {
//    void (^runBlock)() = ^{
//        LKXMLog(@"%s", __FUNCTION__);
//    };
//
//    return runBlock;
    
    LKXUser * (^runBlock)(void) = ^{
        LKXMLog(@"%s", __FUNCTION__);
        
        return self;
    };
    return runBlock;
}

- (LKXUser * (^)(void))eat2 {
    return ^{
        LKXMLog(@"%s", __FUNCTION__);
        
        return self;
    };
}

- (LKXUser * (^)(double distance))run3 {
    return ^(double distance) {
        LKXMLog(@"%s -- 跑%f", __FUNCTION__, distance);
        
        return self;
    };
}

- (LKXUser * (^)(NSString *food))eat3 {
    return ^(NSString *food) {
        LKXMLog(@"%s --- 吃%@", __FUNCTION__, food);
        
        return self;
    };
}

#pragma mark - LKXUserExports
@synthesize address;

- (nonnull NSString *)updateUser:(nonnull NSDictionary *)info {
    return nil;
}

@end
