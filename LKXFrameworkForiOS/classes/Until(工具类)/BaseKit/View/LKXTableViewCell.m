//
//  LKXTableViewCell.m
//  LKXFrameworkForiOS
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

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // 1. 栅格化,美工术语:将cell中的所有内容，生成一张独立的图片
//        // 在屏幕滚动时，只显示图像
//        self.layer.shouldRasterize = YES;
//        // 栅格化，必须指定分辨率，否则默认使用*1，生成图像
//        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        
//        // 2.异步绘制,如果cell比较复杂，可以使用
//        self.layer.drawsAsynchronously = YES;
//    }
//    return self;
//}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
- (void)setContentModel:(id)contentModel {
    
}

@end
