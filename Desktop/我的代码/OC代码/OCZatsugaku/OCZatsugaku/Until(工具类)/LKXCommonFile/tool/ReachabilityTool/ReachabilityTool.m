//
//  ReachabilityTool.m
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "ReachabilityTool.h"

// 检测是否有网的网络地址
#define kReachabilityHostName @"www.baidu.com"

@implementation ReachabilityTool

// 判断网络是否可用
+ (BOOL)isConnectAvailable
{
    BOOL isExistenceNetwork = [self isConnectAvailableWithShow:NO];
    
    return isExistenceNetwork;
}

/**
 *  判断网络是否可用
 *
 *  @param isShow 是否显示提示信息
 *
 *  @return BOOL
 */
+ (BOOL)isConnectAvailableWithShow:(BOOL)isShow
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    //判断网络是否可用，不判断则打开，判断则屏蔽
    if (isJudgeNet)
    {
        return YES;
    }
    
    BOOL isExistenceNetwork = YES;
    Reachability *reachability = [Reachability reachabilityWithHostName:kReachabilityHostName];
    NetworkStatus status = [reachability currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
        default:
            break;
    }
    
    if (!isExistenceNetwork && isShow)
    {
        [kMBHUDTool showHUDWithText:kLocalizedString(@"网络连接异常") delay:kMBHUDDelay];
    }
    
    return isExistenceNetwork;
}

@end
