//
//  UIView+LKXBase.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2020/10/11.
//  Copyright © 2020 刘克邪. All rights reserved.
//

#import "UIView+LKXBase.h"

@implementation UIView (LKXBase)

- (void)setLkx_x:(CGFloat)lkx_left {
    CGRect frame = CGRectMake(lkx_left, self.lkx_y, self.lkx_width, self.lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_x {
    return self.frame.origin.x;
}

- (void)setLkx_y:(CGFloat)lkx_top {
    CGRect frame = CGRectMake(self.lkx_x, lkx_top, self.lkx_width, self.lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_y {
    return self.frame.origin.y;
}

- (CGFloat)lkx_right {
    return self.lkx_x + self.lkx_width;
}

- (CGFloat)lkx_bottom {
    return self.lkx_y + self.lkx_height;
}

- (void)setLkx_width:(CGFloat)lkx_width {
    CGRect frame = CGRectMake(self.lkx_x, self.lkx_y, lkx_width, self.lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_width {
    return self.frame.size.width;
}

- (void)setLkx_height:(CGFloat)lkx_height {
    CGRect frame = CGRectMake(self.lkx_x, self.lkx_y, self.lkx_width, lkx_height);
    self.frame = frame;
}

- (CGFloat)lkx_height {
    return self.frame.size.height;
}

- (CGSize)lkx_size {
    return self.frame.size;
}

- (void)setLkx_size:(CGSize)lkx_size {
    CGRect frame = self.frame;
    frame.size = lkx_size;
    self.frame = frame;
}

- (CGPoint)lkx_origin {
    return self.frame.origin;
}

- (void)setLkx_origin:(CGPoint)lkx_origin {
    CGRect frame = self.frame;
    frame.origin = lkx_origin;
    self.frame = frame;
}

@end
