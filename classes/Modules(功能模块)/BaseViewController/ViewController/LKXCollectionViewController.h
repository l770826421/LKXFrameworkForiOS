//
//  LKXCollectionViewController.h
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXScrollViewController.h"

/**
 *  @author 刘克邪
 *
 *  @brief  带UICollectionView的VC
 */
@interface LKXCollectionViewController : LKXScrollViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/** UIConllectionView的风格 */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

/** UICollection */
@property (nonatomic, strong) UICollectionView *collectionView;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
