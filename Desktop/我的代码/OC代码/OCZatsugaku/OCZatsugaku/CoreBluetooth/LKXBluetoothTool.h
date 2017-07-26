//
//  LKXBluetoothTool.h
//  OCZatsugaku
//
//  Created by lkx on 2017/7/4.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class LKXBluetoothTool;

@protocol LKXBluetoothToolDelegate <NSObject>

@optional

/**
 找到可用设备

 @param blutooth 蓝牙工具类
 @param peripheral 可用设备对象
 @param advertisementData 数据
 @param RSSI RSSI
 */
- (void)bluetoothTool:(LKXBluetoothTool * _Nonnull)blutooth
didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral
    advertisementData:(NSDictionary<NSString *,id> * _Nonnull)advertisementData
                 RSSI:(NSNumber * _Nonnull)RSSI;

/**
 连接成功
 */
- (void)bluetoothTool:(LKXBluetoothTool * _Nonnull)blutooth
 didConnectPeripheral:(CBPeripheral * _Nonnull)peripheral;

@end

/**
 蓝牙工具类
 */
@interface LKXBluetoothTool : NSObject

+ (instancetype _Nonnull)shareBluetoothTool;

@property (nonatomic, weak) id<LKXBluetoothToolDelegate> delegate;

/**
 开始扫描
 
 @param serviceUUIDs 接受的外设，空则表示全部接受
 @param options 信息,一般为nil
 */
- (void)scanForPeripheralsWithServices:(NSArray<CBUUID *> * _Nonnull)serviceUUIDs
                               options:(nullable NSDictionary<NSString *,id> *)options;

/**
 链接外设
 
 @param peripheral 外设对象
 @param options 信息,一般为nil
 */
- (void)connectPeripheral:(CBPeripheral * _Nonnull)peripheral options:(nullable NSDictionary<NSString *,id> *)options;

/**
 停止扫描
 */
- (void)stopScan;

/**
 获取外设的所有service
 */
- (void)discoverServices:(NSArray * _Nonnull)services;

@end
