//
//  LKXSpringCollectionViewFlowLayout.h
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/5/22.
//  Copyright (c) 2015年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 弹簧TableView
 */
@interface LKXSpringCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 弹簧阻尼
 */
@property (nonatomic, assign) CGFloat springDamping;
/**
 弹簧频率
 */
@property (nonatomic, assign) CGFloat springFrequency;
/**
 阻力系数
 */
@property (nonatomic, assign) CGFloat resistanceFactor;

@end
