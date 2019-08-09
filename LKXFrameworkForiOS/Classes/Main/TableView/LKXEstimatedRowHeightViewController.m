//
//  LKXEstimatedRowHeightViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/8/30.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXEstimatedRowHeightViewController.h"
#import "LKXEstimatedRowHeightCell.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define isXR 1

#if isXR
    // 本设备
    NSString *iBeaconIdentifier = @"iPhone XR test beacon";
    NSString *uuidString= @"B9842E9B-3086-4D53-8111-B02C98920C04";

    // 目标设备
    NSString *tagIBeaconIdentifier = @"black iPhone";
    NSString *tagUuidString= @"073CA21B-1858-4867-90C2-490E1FDA45E3";
#else
    // 本设备
    NSString *iBeaconIdentifier = @"black iPhone";
    NSString *uuidString= @"073CA21B-1858-4867-90C2-490E1FDA45E3";

    // 目标设备
    NSString *tagIBeaconIdentifier = @"iPhone XR test beacon";
    NSString *tagUuidString= @"B9842E9B-3086-4D53-8111-B02C98920C04";
#endif

@interface LKXEstimatedRowHeightViewController () <CLLocationManagerDelegate, CBPeripheralManagerDelegate, CBCentralManagerDelegate>

/** 提示板 */
@property(nonatomic, strong) UITextView *footerTextView;
/** 信息 */
@property(nonatomic, strong) NSMutableString *messageM;

@end

@implementation LKXEstimatedRowHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self autolayoutTableView];
    [self setData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setData {
    NSString *src = @"发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾";
    [self.dataSource addObject:src];
    
    src = @"发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾";
    [self.dataSource addObject:src];
    
    src = @"发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾";
    [self.dataSource addObject:src];
    
    src = @"发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾";
    [self.dataSource addObject:src];
    
    src = @"发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾";
    [self.dataSource addObject:src];
    
    src = @"发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 ";
    [self.dataSource addObject:src];
    
    src = @"发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾  发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾 发记录是否拉法； 经发局法拉发顺丰就拉十几分垃圾";
    [self.dataSource addObject:src];
    
    [self.tableView reloadData];
    
    _footerTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 120)];
    _footerTextView.textColor = [UIColor redColor];
    _footerTextView.font = [UIFont systemFontOfSize:13];
    _footerTextView.backgroundColor = [UIColor greenColor];
    self.tableView.tableFooterView = _footerTextView;
    
    _messageM = [NSMutableString string];
    
//    [self toIBeacon];
//    [self addIBeacon];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKXEstimatedRowHeightCell *cell = [LKXEstimatedRowHeightCell cellWithTableView:tableView];
    cell.src = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - iBeacon检测功能
/**
 添加iBeacon目标
 */
- (void)addIBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:tagUuidString];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    
    CLBeaconRegion *beacon = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                identifier:tagIBeaconIdentifier];
    
    [locationManager startMonitoringForRegion:beacon];
}


/**
 将设备注册为iBeacon
 */
- (void)toIBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:uuidString];
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:iBeaconIdentifier];
    // 蓝牙监测
    NSDictionary *peripheraDic = [region peripheralDataWithMeasuredPower:nil];
    CBPeripheralManager *peripheraManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
    CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    if (centralManager.isScanning) {
        [peripheraManager startAdvertising:peripheraDic];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(nonnull CLRegion *)region {
    if ([[region identifier] isEqualToString:tagIBeaconIdentifier]) {
        [_messageM appendFormat:@"匹配到%@\n", tagIBeaconIdentifier];
        _footerTextView.text = _messageM;
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [beacons objectAtIndex:0];
    switch ([beacon proximity]) {
        case CLProximityUnknown: // 区域未定义
            [_messageM appendFormat:@"在未定义区域\n"];
            break;
        case CLProximityImmediate: // 设备与信标很接近
            [_messageM appendFormat:@"设备与信标很接近\n"];
            break;
        case CLProximityNear: // 设备与信标在几米之内
            [_messageM appendFormat:@"设备与信标在几米之内\n"];
            break;
        case CLProximityFar: // 设备处于区域内,但是靠近区域边缘
            [_messageM appendFormat:@"设备处于区域内,但是靠近区域边缘\n"];
            break;
        default:
            break;
    }
    _footerTextView.text = _messageM;
}

#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    [_messageM appendString:@"peripheralManagerDidUpdateState"];
    _footerTextView.text = _messageM;
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            LKXMLog(@"on");
            break;
            
        default:
            break;
    }
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    [_messageM appendString:@"centralManagerDidUpdateState"];
    _footerTextView.text = _messageM;
}

@end
