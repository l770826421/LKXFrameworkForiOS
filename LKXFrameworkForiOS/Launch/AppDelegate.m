//
//  AppDelegate.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/19.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "AppDelegate.h"

#import "LKXTabBarController.h"
#import "LKXUser.h"
#import "NSObject+LKXRuntime.h"

#define kRestoreApplicationStateKey @"kRestoreApplicationStateKey"

@interface AppDelegate ()

@end

@implementation AppDelegate {
    LKXTabBarController *_tabBarController;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 测试
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    _tabBarController = [[LKXTabBarController alloc] init];
    self.window.rootViewController = _tabBarController;
    
    [self objectForRuntime];
    LKXMLog(@"----%@---", NSStringFromSelector(@selector(objectForRuntime)));
    [self functionAndChainForProgram];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    NSMutableArray *viewcontrollers = [_tabBarController.viewControllers copy];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:viewcontrollers];
    [coder encodeObject:data forKey:kRestoreApplicationStateKey];
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    NSData *data = [coder decodeObjectForKey:kRestoreApplicationStateKey];
    NSArray *viewControllers = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _tabBarController.viewControllers = viewControllers;
    
}

#pragma mark - other

/**
 runtime在字典转模型的应用
 */
- (void)objectForRuntime {
    [LKXUser lkx_propertyList];
    LKXUser *user =
    [LKXUser lkx_objectWithDictionary:@{
                                        @"name" : @"张三",
                                        @"age" : @12,
                                        @"hight" : @170,
                                        @"nickname" : @"大西瓜"
                                        }];
    LKXMLog(@"user = %@", user.description);
}

/**
 函数编程和链式编程
 */
- (void)functionAndChainForProgram {
    LKXUser *user = [[LKXUser alloc] init];
    // 链式编程
    // 1.传统的写法
    // 1> run和eat需要单独调用
    // 2> 不能随意组合顺序
    [user run];
    [user eat];
    
    // 2.可以连续调用
    // 例如: [[user run] eat];
    [[user run1] eat1];
    
    // 3.函数式编程
    // 在OC中什么时候会用到'()' -> 执行'block需要()'
    user.run2().eat2();
    
    user.run3(100).eat3(@"water").run3(1000).eat3(@"wind");
}

@end
