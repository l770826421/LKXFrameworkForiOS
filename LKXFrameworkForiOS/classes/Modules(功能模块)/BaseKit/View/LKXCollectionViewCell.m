//
//  LKXCollectionViewCell.m
//  XGMEport
//
//  Created by lkx on 16/3/23.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXCollectionViewCell.h"

@implementation LKXCollectionViewCell

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    LKXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setContentModel:(id)contentModel {
    
}

@end
