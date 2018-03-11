//
//  LKXTabBarButton.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTabBarButton.h"

#define kImageHeight 23
#define kSpace 4

@implementation LKXTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:kTabBarItemFontSize];
    [self setTitleColor:ColorWithHex(@"7a7e83") forState:UIControlStateNormal];
    [self setTitleColor:ColorWithHex(@"4b8bd8") forState:UIControlStateSelected];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 28;
    CGFloat imageH = kImageHeight;
    CGFloat imageX = (contentRect.size.width - imageW) / 2;
    CGFloat imageY = kSpace;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = self.lkx_width;
    CGFloat titleH = 30;
    CGFloat titleX = 0;
    CGFloat titleY = self.lkx_height - titleH + kSpace;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

// 取消高亮效果
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:NO];
}

- (void)setItem:(UITabBarItem *)item {
    if (item.image) {
        [self setImage:item.image forState:UIControlStateNormal];
    }
    
    if (item.selectedImage) {
        [self setImage:item.selectedImage forState:UIControlStateSelected];
    }
    
    if (item.title && item.title.length) {
        [self setTitle:item.title forState:UIControlStateNormal];
    }
}

@end
