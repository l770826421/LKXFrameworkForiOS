//
//  LKX_Tooles.m
//  LKXFrameworkForiOS
//
//  Created by xzs on 13-4-19.
//  Copyright (c) 2013年 cnmobi . All rights reserved.
//

#import "LKX_Tooles.h"

#define MsgBox(msg) [self MsgBox:msg]

@implementation LKX_Tooles

#pragma mark - 日期的具体信息

#pragma mark - 打开一个网址
//打开一个网址
+ (void) OpenUrl:(NSString *)inUrl
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:inUrl]];
}

#pragma mark - 闪光灯开关turnTorchOn
+ (void)turnTorchOn:(BOOL)on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark - AttributedString 设置
+ (NSAttributedString *)attributedString:(NSString *)String
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0.0, 0.0);//CGSizeMake(0.5, 0.5);
    NSAttributedString *AString;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        AString = [[NSAttributedString alloc]initWithString:String
                                                 attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             RGBCOLOR(255, 255, 255), NSForegroundColorAttributeName,
                                                             shadow, NSShadowAttributeName,
                                                             [UIFont systemFontOfSize:14.0], NSFontAttributeName, nil]];
    }
    else
    {
        AString = [[NSAttributedString alloc]initWithString:String];
    }
    
    return AString;
}



#pragma mark - 经纬度距离计算
//根据两经纬度计算两点距离
+(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    return  distance/1000;

    //返回 m
//    return   distance;
    
}



#pragma mark - 把原来Dictionary里面的空对象转成字符长度为0的string
//把原来Dictionary里面的空对象转成字符长度为0的string
+(id)resetDication:(NSMutableDictionary *)srcDict
{
    NSArray *KeyArray = [srcDict allKeys];
    for (NSString *KeyStr in KeyArray)
    {
        id object = [srcDict objectForKey:KeyStr];
        if ((NSNull *)object == [NSNull null])
        {
            [srcDict setObject:@"" forKey:KeyStr];
        }
    }
    return srcDict;
}

#pragma mark - 设备支持
//判断当前设备是否支持IPone
+ (BOOL)isPhoneSupported
{
    NSString *deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPhone"];
}

//判断是设备是否IPad
+ (BOOL)isPad
{
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}

//返回当前设备的握持姿势
+ (UIDeviceOrientation)deviceOrientation
{
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    if (orient == UIDeviceOrientationUnknown)
    {
        return UIDeviceOrientationPortrait;
    }
    else {
        return orient;
    }
}

//判断当前的设备是否支持该手持姿势，IPad全支持，IPhone不允许倒立持握
+ (BOOL)isSupportedOriention:(UIInterfaceOrientation) orientation
{
    if ([self isPad])
        return YES;
    else
    {
        switch (orientation)
        {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                return YES;
            default:
                return NO;
        }
    }
}


//判断旋转
+ (CGAffineTransform)rotateTransformForOrientTation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft)
    {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    }
    else if(orientation == UIInterfaceOrientationLandscapeRight)
    {
        return CGAffineTransformMakeRotation(M_PI/2);
    }
    else if(orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return CGAffineTransformMakeRotation(-M_PI);
    }
    else
        return CGAffineTransformIdentity;
}


@end
