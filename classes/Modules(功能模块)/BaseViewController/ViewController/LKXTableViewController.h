//
//  LKXTableViewController.h
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXScrollViewController.h"

/**
 *  @author 刘克邪
 *
 *  @brief  带一个创建的tableView
 */
@interface LKXTableViewController : LKXScrollViewController <UITableViewDataSource, UITableViewDelegate>

/**
 *  @author 刘克邪
 *
 *  @brief  初始化
 *
 *  @param style tableView的风格
 */
- (instancetype)initWithTableViewStyle:(UITableViewStyle)style;

/** tableView,默认是autolayout */
@property (nonatomic, strong) UITableView *tableView;

/** tableViewStyle */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/** 当前页码 */
@property (nonatomic, assign) NSUInteger currentPage;

/** dataSource,默认是一维数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;

#pragma mark - other
/**
 *  @author 刘克邪
 *
 *  @brief  去除UITableView多余的cellLine
 *
 *  @param tableView 目标UITableView
 *  @param hidden    YES->隐藏,NO->不隐藏
 */
- (void)setExtraCellLineWithTableView:(UITableView *)tableView
                               hidden:(BOOL)hidden;

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
