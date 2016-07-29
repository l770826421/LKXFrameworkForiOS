//
//  Macros_UICommon.h
//  MyCategory
//
//  Created by Developer on 15/9/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#ifndef MyCategory_Macros_UICommon_h
#define MyCategory_Macros_UICommon_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>                                   //需要添加 QuartzCore.framework 库函数
#import "UIColor+Category.h"

#pragma mark - 设备相关
/** 
  * 此处宏定义用于当前苹果设备的硬件参数,
  * 屏幕宽度和屏幕高度
  * 宏定义屏幕相关视图尺寸
 */

#define Dev_Name            [UIDevice currentDevice].name                           //返回当前设备名称
#define Dev_IOSName         [UIDevice currentDevice].systemName                     //返回当前系统名称
#define Dev_IOSVersion      [[[UIDevice currentDevice] systemVersion] floatValue]   //返回当前系统版本号

#define Dev_ScreenBounds    [UIScreen mainScreen].bounds                            //返回屏幕Bounds
#define Dev_ScreenOrigin    Dev_ScreenBounds.origin                                 //返回屏幕原点
#define Dev_ScreenSize      Dev_ScreenBounds.size                                   //返回屏幕尺寸
#define Dev_ScreenOriginX   Dev_ScreenOrigin.x                                      //返回屏幕原点坐标X
#define Dev_ScreenOriginY   Dev_ScreenOrigin.y                                      //返回屏幕原点坐标Y
#define Dev_ScreenWidth     Dev_ScreenSize.width                                    //返回屏幕宽度
#define Dev_ScreenHeight    Dev_ScreenSize.height                                   //返回屏幕高度
#define Dev_ScreenScale     [UIScreen mainScreen].scale                             //屏幕分辨率
#define Dev_NavigationHeight 64.f                         //返回状态栏的高度
#define Dev_TabbarHeight 49.f                             //返回Tabbar的高度

#define Dev_AppFrame        [UIScreen mainScreen].applicationFrame                  //返回应用程序Frame
#define Dev_AppFOrigin      Dev_AppFrame.origin                                     //返回应用程序原点
#define Dev_AppFSize        Dev_AppFrame.size                                       //返回应用程序尺寸
#define Dev_AppFOriginX     Dev_AppFOrigin.x                                        //返回应用程序原点坐标X
#define Dev_AppFOriginY     Dev_AppFOrigin.y                                        //返回应用程序原点坐标Y
#define Dev_AppFWidth       Dev_AppFSize.width                                      //返回应用程序宽度
#define Dev_AppFHeight      Dev_AppFSize.height                                     //返回应用程序高度

#define isIPHone4           (Dev_ScreenHeight ==  480) ? YES : NO                   //判断是否是iphone4
#define isIPHone5           (Dev_ScreenHeight ==  568) ? YES : NO                   //判断是否是iphone5
#define isIPHone6           (Dev_ScreenHeight ==  667) ? YES : NO                   //判断是否是iphone6
#define isIPHone6Plus       (Dev_ScreenHeight ==  736) ? YES : NO                   //判断是否是iphone6 plus
#define isIPad              (Dev_ScreenHeight >  568) ? YES : NO                    //判断是否是ipad
#define isHideKeyBarod      ![[UIApplication sharedApplication].keyWindow isFirstResponder]
//判断是否隐藏键盘


#define SIZE_IPhone_Width   320                                                     //返回IPHONE屏幕宽度320
#define SIZE_IPhone_Hight   Dev_ScreenHeight                                        //返回IPHONE屏幕高度568或者480
#define SIZE_IPad_Width     768                                                     //返回IPAD屏幕宽度
#define SIZE_IPad_Hight     1004                                                    //返回IPAD屏幕高度1004

#define SIZE_TableBar_Width         SIZE_IPhone_Width                               //tabbar的宽度
#define SIZE_TableBar_Hight         49                                              //tabbar的高度
#define SIZE_NavBar_Width           SIZE_IPhone_Width                               //导航条的宽度
#define SIZE_NavBar_Hight           44                                              //导航条的宽度
#define SIZE_ToolBar_Width          SIZE_IPhone_Width                               //工具条的宽度
#define SIZE_ToolBar_Hight          44                                              //工具条的宽度
#define SIZE_StateBar_Width         SIZE_IPhone_Width                               //状态栏的宽度
#define SIZE_StateBar_Hight         20                                              //状态栏的高度

#define SIZE_IPhone_KeyboardHigth   216                                             //手机键盘高度


#define Nav_ButWidth                33
#define Nav_ButHight                30
#define Nav_BackBut_Frame           CGRectMake(5, 7, 48, 30)
#define Nav_RightBut_Frame          CGRectMake(SIZE_NavBar_Width - Nav_ButWidth - 5, 7, Nav_ButWidth, Nav_ButHight)

#pragma mark - 颜色相关
//常用颜色
#define CLEARCOLOR [UIColor clearColor]
#define WHITECOLOR [UIColor whiteColor]
#define BLACKCOLOR [UIColor blackColor]
#define REDCOLOR   [UIColor redColor]
#define GRAYCOLOR  [UIColor grayColor]
#define GREENCOLOR [UIColor greenColor]
#define BLUECOLOR  [UIColor blueColor]
#define BROWNCOLOR [UIColor brownColor]

//宏定义该应用程序所有的颜色
#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ColorWithHex(str) [UIColor colorFromHexRGB:str]

// 宏定义创建颜色图片
#define ImageNamed(_name)           [UIImage imageNamed:_name]
#define ImageWithRGB(r,g,b)         [UIView createImageWithColor:RGBCOLOR(r,g,b)]
#define ImageWithColor(Color)       [UIView createImageWithColor:Color]

#pragma mark - 项目Info.plist文件相关

// 读取项目的Info.plist文件
#pragma mark - Info.Plist

#define kInfoPlistDict              [[NSBundle mainBundle] infoDictionary]
#define ReadInfoPlistDict(_name)    [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)_name]
#define kAppVersion                 ReadInfoPlistDict(kCFBundleVersionKey)
#define kAppBundleIdentifier        ReadInfoPlistDict(kCFBundleIdentifierKey)
//#define kAppVersion                 ReadInfoPlistDict(kCFBundleVersionKey)



#pragma mark - 安全释放对象
#define RELEASE_SAFELY(_OPINTER)    {if(_OPINTER) {[_OPINTER release]; _OPINTER = nil; }}


#pragma mark - NSLog 打印
// 调试打印输出 LKXLogState ＝ 1 可以打印， ＝ 0 不打印
#define LKXLogState 1

#define LKXMLog(__format, ... ) if(LKXLogState) NSLog( @"<%p %@:Function:%s,(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __func__, __LINE__, [NSString stringWithFormat:(__format), ##__VA_ARGS__])

#define LKXNLog(__format, ... ) if(LKXLogState) NSLog( @"%@",[NSString stringWithFormat:(__format), ##__VA_ARGS__])



#pragma mark - 字体相关
// 字体格式选择
#pragma mark - UIFont

#define FONT_NewRoman               @"Times New Roman"          //新罗马字体
#define FONT_NewCourier             @"Courier New"              //幼圆
#define FONT_Verdana                @"Verdana"                  //Verdana类型
#define FONT_HeitiSC                @"STHeitiSC-Medium"         //黑体简
#define FONT_HNBold                 @"HelveticaNeue-Bold"       //加粗
#define FONT_123                @"STHeitiSC"         //黑体简


#define FONT_size10                 10.0f
#define FONT_size11                 11.0f
#define FONT_size12                 12.0f
#define FONT_size14                 14.0f
#define FONT_size15                 15.0f
#define FONT_size16                 16.0f
#define FONT_size17                 17.0f
#define FONT_size18                 18.0f
#define FONT_size20                 20.0f
#define FONT_size22                 22.0f
#define FONT_size25                 25.0f

#define FontSize(_size)             [UIFont systemFontOfSize:_size]
#define FontNameSize(_name,_size)   [UIFont fontWithName:_name size:_size]

#pragma mark - 动画相关
// 此处宏定义用于设置VIEW的动画参数,宏定义动画效果

#define AMTION_TYPE_CATFADE         kCATransitionFade           //渐变
#define AMTION_TYPE_CATPUSH         kCATransitionPush           //推挤
#define AMTION_TYPE_CATREVEAL       kCATransitionReveal         //揭开
#define AMTION_TYPE_CATMOVEIN       kCATransitionMoveIn         //覆盖

#define AMTION_TYPE_CUBE            @"cube"                     //立方翻转
#define AMTION_TYPE_SUCKEFFECT      @"suckEffect"               //三角
#define AMTION_TYPE_OGLFLIP         @"oglFlip"                  //上下翻转
#define AMTION_TYPE_RIPPLEEFFECT    @"rippleEffect"             //水波抖动
#define AMTION_TYPE_PAGECURL        @"pageCurl"                 //上翻页
#define AMTION_TYPE_PAGEUNCURL      @"pageUnCurl"               //下翻页
#define AMTION_TYPE_CAMEROPEN       @"cameraIrisHollowOpen"     //相机打开
#define AMTION_TYPE_CAMERCLOSE	    @"cameraIrisHollowClose"    //相机关闭


//宏定义动画的方向
#define AMTION_FROM_LEFT            kCATransitionFromLeft       //从左
#define AMTION_FROM_RIGHT           kCATransitionFromRight      //从右
#define AMTION_FROM_TOP             kCATransitionFromTop        //从顶部
#define AMTION_FROM_BOTTOM          kCATransitionFromBottom     //从底部


#pragma mark - 文件操作
//NSUserDefaults 用户默认值
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kFileManager  [NSFileManager defaultManager]

//监听
#define kNotifi [NSNotificationCenter defaultCenter]

//文件保存目录
#define PATH_OF_DOCUMENT        [NSHomeDirectory()  stringByAppendingPathComponent:@"Documents"]
//
#define FILE_PATH_OF_DOCUMENT(fileName) [PATH_OF_DOCUMENT stringByAppendingPathComponent:fileName]

#define kAppDelegate [UIApplication sharedApplication].delegate
#define kLocalizedString(string) NSLocalizedString(string, nil)

#endif
