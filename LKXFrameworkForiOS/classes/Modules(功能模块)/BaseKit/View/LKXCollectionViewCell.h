//
//  LKXCollectionViewCell.h
//  XGMEport
//
//  Created by lkx on 16/3/23.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author 刘克邪
 *
 *  @brief  自定义的UICollectionViewCell基类
 */
@interface LKXCollectionViewCell : UICollectionViewCell

/**
 *  @author 刘克邪
 *
 *  @brief  复用实例化方法
 *
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

/** 填充cell的UI数据 */
@property (nonatomic, strong) id contentModel;

@end
