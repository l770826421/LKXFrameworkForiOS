//
//  LKXEstimatedRowHeightViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/8/30.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXEstimatedRowHeightViewController.h"
#import "LKXEstimatedRowHeightCell.h"

@interface LKXEstimatedRowHeightViewController ()

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

@end
