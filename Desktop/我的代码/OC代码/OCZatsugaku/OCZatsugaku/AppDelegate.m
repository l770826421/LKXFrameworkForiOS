//
//  AppDelegate.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/22.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "AppDelegate.h"
#import "LKXUNLocalNotificationTool.h"
#import "LKXRequestManager.h"
#import "NSURLSessionTask+OCCategory.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (Dev_IOSVersion >= 10.0) {
        [[LKXUNLocalNotificationTool shareLocalNotificationTool] registerLocalNotification];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // 使用百度坐标拾取器接口
    [[LKXRequestManager shareRequestManager] rootDataRequestWithSuccess:^{
        LKXMLog(@"使用百度坐标拾取器接口成功");
    } failure:^(NSString *message) {
        LKXMLog(@"使用百度坐标拾取器接口失败:%@", message);
    }];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [task test];
    LKXMLog(@"%@", [task class]);
    LKXMLog(@"%@", [task superclass]);
    LKXMLog(@"%@", [[task class] superclass]);
    LKXMLog(@"%@", [[[task class] superclass] superclass]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    LKXMLog(@"application接受到本地通知:%@", notification);
}

@end
