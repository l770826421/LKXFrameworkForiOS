//
//  LKXCollectionViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXCollectionViewController.h"
#import "LKXCollectionViewCell.h"
#import "Macros_UICommon.h"

#import <Masonry/Masonry.h>

@interface LKXCollectionViewController ()

@end

@implementation LKXCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentPage = 1;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @author 刘克邪
 *
 *  @brief  如果只有collection一个子控件就调用这个方法进行布局
 */
- (void)autolayoutCollection {
//    [self.view addConstraints:[NSLayoutConstraint lkx_constraintsWithItem:self.collectionView]];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - setter and getter
@synthesize flowLayout = _flowLayout;
- (void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout {
    if (flowLayout) {
        _flowLayout = flowLayout;
    }
    
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = LKXCollectionMinimumInteritemSpacing;
        _flowLayout.minimumLineSpacing = LKXCollectionMinimumLineSpacing;
    }
    return _flowLayout;
}

@synthesize collectionView = _collectionView;
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _collectionView.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

@synthesize dataSource = _dataSource;
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - UICollectionViewDataSoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LKXCollectionViewCell *cell = [LKXCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.contentModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

#pragma mark - Other
/**
 *  @author 刘克邪
 *
 *  @brief  上拉获取数据
 */
- (void)downRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
}

/**
 *  @author 刘克邪
 *
 *  @brief  下拉获取数据
 */
- (void)pullRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_footer endRefreshing];
    });
}

@end
