//
//  OCBlutoothViewController.m
//  OCZatsugaku
//
//  Created by lkx on 2017/7/4.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "OCBlutoothViewController.h"
#import "LKXBluetoothTool.h"

@interface OCBlutoothViewController () <UITableViewDelegate, UITableViewDataSource, LKXBluetoothToolDelegate>

/** 蓝牙工具类 */
@property(nonatomic, strong) LKXBluetoothTool *bluetoothTool;
/** 数据源 */
@property(nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OCBlutoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bluetoothTool = [LKXBluetoothTool shareBluetoothTool];
    self.bluetoothTool.delegate = self;
    self.dataSource = [NSMutableArray array];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_bluetoothTool scanForPeripheralsWithServices:nil options:nil];
    } else {
        [_bluetoothTool stopScan];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CBPeripheral *peripheral = self.dataSource[indexPath.row];
    cell.textLabel.text = peripheral.description;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral *peripheral = self.dataSource[indexPath.row];
    [self.bluetoothTool connectPeripheral:peripheral options:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - LKXBluetoothToolDelegate
- (void)bluetoothTool:(LKXBluetoothTool *)blutooth didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    [self.dataSource addObject:peripheral];
    [self.tableView reloadData];
}

- (void)bluetoothTool:(LKXBluetoothTool * _Nonnull)blutooth
 didConnectPeripheral:(CBPeripheral * _Nonnull)peripheral{
    LKXMLog(@"%@连接成功", peripheral);
    [self.bluetoothTool discoverServices:nil];
}

@end
