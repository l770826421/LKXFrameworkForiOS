//
//  OCLocalNotificationViewController.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/22.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "OCLocalNotificationViewController.h"
#import "LKXUNLocalNotificationTool.h"
#import <CoreLocation/CoreLocation.h>
#import "LKXLocalNotificationTool.h"

@interface OCLocalNotificationViewController ()

@end

@implementation OCLocalNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 注册本地通知
 */
- (IBAction)addLocalNotificationAction:(id)sender {
    // 初始化本地通知
//    UILocalNotification
    
    if (Dev_IOSVersion >= 10.0) {
        [[LKXUNLocalNotificationTool shareLocalNotificationTool] localNotificationWithTitle:@"主题"
                                                                                  subTtitle:@"副标题"
                                                                                      badge:1
                                                                                       body:@"dfjasfjaslfajsfl"
                                                                        timeIntervalTrigger:10
                                                                                    repeats:NO
                                                                                 identifier:@"fajklfd"];
    } else {
        [[LKXLocalNotificationTool shareLocalNotificationTool] localNotificationWithFireDate:20
                                                                                   alertBody:@"iOS8"
                                                                                    soudName:UILocalNotificationDefaultSoundName
                                                                              repeatInterval:NSCalendarUnitEra
                                                                                       badge:1
                                                                                    userInfo:@{@"id" : @"iOS8"}];
    }
    
}

- (IBAction)dateComponentLocalNotificationAction:(id)sender {
    if (Dev_IOSVersion < 10.0) {
        return;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *componets = [calendar components:unitFlags fromDate:[NSDate date]];
    componets.second += 15;
    
    [[LKXUNLocalNotificationTool shareLocalNotificationTool] localNotificationWithTitle:@"DateComponents主题"
                                                                              subTtitle:@"DateComponents副标题"
                                                                                  badge:1
                                                                                   body:@"DateComponents -dfjasfjaslfajsfl"
                                                                            dateTrigger:componets
                                                                                repeats:NO
                                                                             identifier:@"DateComponents"];
}

- (IBAction)regionLocalNotificationAction:(id)sender {
    if (Dev_IOSVersion < 10.0) {
        return;
    }
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(113.934456, 22.498104) radius:kCLLocationAccuracyKilometer identifier:@"蛇口"];
    [[LKXUNLocalNotificationTool shareLocalNotificationTool] localNotificationWithTitle:@"地区主题"
                                                                              subTtitle:@"地区副标题"
                                                                                  badge:1
                                                                                   body:@"地区 -dfjasfjaslfajsfl"
                                                                          regionTrigger:region
                                                                                repeats:NO
                                                                             identifier:@"region"];
}

@end
