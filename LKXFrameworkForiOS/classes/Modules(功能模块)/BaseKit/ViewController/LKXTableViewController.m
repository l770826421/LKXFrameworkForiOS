//
//  LKXTableViewController.m
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTableViewController.h"

#import "LKXTableViewCell.h"

#import "LKXLayoutContraint.h"

@interface LKXTableViewController ()

@end

@implementation LKXTableViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  @author 刘克邪
 *
 *  @brief  初始化
 *
 *  @param style tableView的风格
 */
- (instancetype)initWithTableViewStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        self.tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentPage = 1;
    
    [self.view addSubview:self.tableView];
    
    [self setExtraCellLineWithTableView:self.tableView hidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @author 刘克邪
 *
 *  @brief  如果只有tableView一个子控件就调用这个方法进行布局
 */
- (void)autolayoutTableView {
    [self.view addConstraints:[NSLayoutConstraint lkx_constraintsWithItem:self.tableView]];
}

#pragma mark - setter and getter
@synthesize tableView = _tableView;
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    return _tableView;
}

@synthesize dataSource = _dataSource;
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKXTableViewCell *cell = [LKXTableViewCell cellWithTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}


#pragma mark - other
/**
 *  @author 刘克邪
 *
 *  @brief  去除UITableView多余的cellLine
 *
 *  @param tableView 目标UITableView
 *  @param hidden    YES->隐藏,NO->不隐藏
 */
- (void)setExtraCellLineWithTableView:(UITableView *)tableView hidden:(BOOL)hidden {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = tableView.backgroundColor;
    if (hidden) {
        tableView.tableFooterView = view;
    }
}

/**
 *  @author 刘克邪
 *
 *  @brief  上拉获取数据
 */
- (void)downRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

/**
 *  @author 刘克邪
 *
 *  @brief  下拉获取数据
 */
- (void)pullRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}

@end
