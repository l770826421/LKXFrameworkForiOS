//
//  LKXSpringCollectionViewFlowLayout.h
//  MyCategory
//
//  Created by Developer on 15/5/22.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKXSpringCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat springDamping;
@property (nonatomic, assign) CGFloat springFrequency;
@property (nonatomic, assign) CGFloat resistanceFactor;

@end
