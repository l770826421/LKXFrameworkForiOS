//
//  LKXEstimatedRowHeightCell.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/8/30.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXEstimatedRowHeightCell.h"
#import "Masonry.h"

@interface LKXEstimatedRowHeightCell ()

/** t */
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation LKXEstimatedRowHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(8, 8, 8, 8));
        }];
    }
    return self;
}

- (void)setSrc:(NSString *)src {
    _src = src;
    _titleLabel.text = _src;
}

@end
