//
//  LKX_Tooles.h
//  LKXFrameworkForiOS
//
//  Created by 李恩 on 13-4-19.
//  Copyright (c) 2013年 cnmobi . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface LKX_Tooles : NSObject

/** 直接传入精度丢失有问题的Double类型*/
NSString *decimalNumberWithDouble(double conversionValue);

//打开一个网址
+ (void)OpenUrl:(NSString *)inUrl;

#pragma mark - 闪光灯开关turnTorchOn
+ (void)turnTorchOn:(BOOL)on;

#pragma mark - AttributedString
+ (NSAttributedString *)attributedString:(NSString *)String;

#pragma mark - 根据经纬度测算距离
+ (double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2;

//把原来Dictionary里面的空对象转成字符长度为0的string
+ (id)resetDication:(NSMutableDictionary *)srcDict;

#pragma mark - 设备支持
+ (BOOL)isPhoneSupported;                                    //判断当前设备是否支持IPone
+ (BOOL)isPad;                                               //判断是设备是否IPad
/**
 获取设备的旋转方向
 UIDeviceOrientation: 是机器硬件的当前旋转方向,只读
 
 @return 设备的旋转方向
 */
+ (UIDeviceOrientation)deviceOrientation;


//判断当前的设备是否支持该手持姿势，IPad全支持，IPhone不允许倒立持握
+ (BOOL)isSupportedOriention:(UIInterfaceOrientation) orientation;

//判断旋转
+ (CGAffineTransform)rotateTransformForOrientTation:(UIInterfaceOrientation)orientation;

@end
