//
//  ReachabilityTool.h
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Reachability.h"

//判断网络是否可用，1判断直接默认网络可用，0不判断网络环境
#define isJudgeNet   0

@interface ReachabilityTool : NSObject

// 判断网络是否可用
+ (BOOL)isConnectAvailable;

/**
 *  判断网络是否可用
 *
 *  @param isShow 是否显示提示信息
 *
 *  @return BOOL
 */
+ (BOOL)isConnectAvailableWithShow:(BOOL)isShow;

@end
