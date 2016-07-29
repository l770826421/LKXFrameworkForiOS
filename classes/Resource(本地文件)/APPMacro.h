//
//  APPMacro.h
//  XGMEport
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#ifndef APPMacro_h
#define APPMacro_h

// 各个屏幕的比例,这取最小屏
#define LKXDesignScale  (480.0 / Dev_ScreenHeight)

/*********** UITabBar ***************/
#define kTabBarItemFontSize 12
#define kTabBarItemFontColorNormal ColorWithHex(@"7a7e83")
#define kTabBarItemFontColorSelected ColorWithHex(@"7a7e83")


/*********** ViewController ***************/
#define kAPPMainColor RGBCOLOR(57, 115, 210)
#define kAPPVCMainColor RGBCOLOR(241, 241, 241)
#define kCellColor RGBCOLOR(204, 204, 204)
#define kCellLightColor RGBCOLOR(224, 224, 224)

/*********** 全局的圆角 ***************/
#define kViewCornerRedius 4.0


/*********** 字体大小颜色 ***************/
#define kButtonFontSize 18
#define kTextSmallerFontSize 12
#define kTextSmallFontSize 13
#define kTextMiddleFontSize 15
#define kTextBigFontSize 22
#define kTextBoldFontSize 17
#define kTextMainColor [UIColor blackColor]


/*********** 登录状态记录 ***************/
// 本次是否登录
#define kAPPCurrentLogin @"kAPPLogin"

#define kAPPAccount @"kAPPAccount"
#define kAPPPassword @"kAPPPassword"

/*********** 用户信息 ***************/
#define kUserenter @"天津外代物流有限公司"  // 企业名称
#define kUserInfoFileName @"userInfo.dt"  // 用户信息存放名称


#endif /* APPMacro_h */
