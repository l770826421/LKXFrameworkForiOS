//
//  LKXTableViewCell.m
//  XGMEport
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTableViewCell.h"

@implementation LKXTableViewCell

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    LKXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[self class] identifier]];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
- (void)setContentModel:(id)contentModel {
    
}

@end
