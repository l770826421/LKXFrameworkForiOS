//
//  LKXAPPDefine.h
//  LKXFrameworkForiOS
//
//  Created by qiaoxing on 13-1-18.
//  Copyright (c) 2013年 My company name. All rights reserved.
//

#import "Macros_UICommon.h"

#import "ChineseToPinyin.h"

#import "MBHUDTool.h"
#define kMBHUDTool [MBHUDTool sharedMBHUDTool]

#import <Reachability/Reachability.h>
#import "UIView+Common.h"
#import "LKX_Tooles.h"

#import "NSString+LKXCategory.h"
#import "NSString+LKXVerification.h"
#import "NSString+LKXEncryption.h"

//判断网络是否可用，1判断直接默认网络可用，0不判断网络环境
#define isJudgeNet 0

// 网络状态
#define kConnectNetwork @"kConnectNetwork"

/**
 WebView的请求方式
 */
typedef NS_ENUM(NSInteger, LKXWebViewHTTPMethod) {
    LKXWebViewHTTPMethodGET,
    LKXWebViewHTTPMethodPOST
};

