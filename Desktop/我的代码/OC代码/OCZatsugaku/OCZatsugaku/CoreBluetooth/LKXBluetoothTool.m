//
//  LKXBluetoothTool.m
//  OCZatsugaku
//
//  Created by lkx on 2017/7/4.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "LKXBluetoothTool.h"

@interface LKXBluetoothTool () <CBCentralManagerDelegate, CBPeripheralDelegate>

/** 控制中心,接受数据 */
@property(nonatomic, strong) CBCentralManager *centralManager;
/** 当前连接的外设 */
@property(nonatomic, strong) CBPeripheral *peripheral;

@end

@implementation LKXBluetoothTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static LKXBluetoothTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

+ (instancetype)shareBluetoothTool {
    LKXBluetoothTool *instance = [[LKXBluetoothTool alloc] init];
    return instance;
}

/**
 开始扫描

 @param serviceUUIDs 接受的外设，空则表示全部接受
 @param options 信息,一般为nil
 */
- (void)scanForPeripheralsWithServices:(NSArray<CBUUID *> *)serviceUUIDs
                               options:(nullable NSDictionary<NSString *,id> *)options {
    [_centralManager scanForPeripheralsWithServices:serviceUUIDs
                                            options:options];
}

/**
 链接外设

 @param peripheral 外设对象
 @param options 信息,一般为nil
 */
- (void)connectPeripheral:(CBPeripheral *)peripheral options:(nullable NSDictionary<NSString *,id> *)options {
    [self stopScan];
    self.peripheral = peripheral;
    peripheral.delegate = self;
    [_centralManager connectPeripheral:peripheral options:options];
}

/**
 停止扫描
 */
- (void)stopScan {
    [_centralManager stopScan];
}

/**
 获取外设的所有service
 */
- (void)discoverServices:(NSArray *)services {
    [_peripheral discoverServices:services];
}

/**
 搜索service的characteristic

 @param characteristicUUIDs UUID数组
 @param service service
 */
- (void)discoverCharacteristics:(nullable NSArray<CBUUID *> *)characteristicUUIDs forService:(nonnull CBService *)service {
    [_peripheral discoverCharacteristics:characteristicUUIDs forService:service];
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    LKXMLog(@"控制中心更新状态:%@", central);
}

/**
 找到可用设备
 */
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                  RSSI:(NSNumber *)RSSI {
    LKXMLog(@"找到可用设备:%@", peripheral);
    if ([self.delegate respondsToSelector:@selector(bluetoothTool:didDiscoverPeripheral:advertisementData:RSSI:)]) {
        [self.delegate bluetoothTool:self
               didDiscoverPeripheral:peripheral
                   advertisementData:advertisementData
                                RSSI:RSSI];
    }
}

/**
 连接成功
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    LKXMLog(@"%@已连接", peripheral);
    if ([self.delegate respondsToSelector:@selector(bluetoothTool:didConnectPeripheral:)]) {
        [self.delegate bluetoothTool:self
                didConnectPeripheral:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    LKXMLog(@"连接失败:%@, error:%@", peripheral, error);
}

#pragma mark - CBPeripheralDelegate
/**
 获取可用设备的service
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        LKXMLog(@"%@可用设备的service:%@", peripheral, service);
        [self discoverCharacteristics:nil forService:service];
    }
}

/**
 找到所有的characteristic
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    for (CBCharacteristic *characteristic in service.characteristics) {
        LKXMLog(@"%@的%@下的characteristic:%@", peripheral, service, characteristic);
    }
}

@end
