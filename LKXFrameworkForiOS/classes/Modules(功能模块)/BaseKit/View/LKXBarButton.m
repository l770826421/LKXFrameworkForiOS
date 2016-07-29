//
//  LKXBarButton.m
//  SLShop
//
//  Created by lkx on 16/5/6.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXBarButton.h"

#define kButtonProportion (self.Height / 44.0)
#define kMargin 4
#define kTitleContentRectHeight (18.0 * kButtonProportion)

@implementation LKXBarButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    if (self.Height > kTitleContentRectHeight) {
        
        titleRect = CGRectMake(0, self.Height - kTitleContentRectHeight, self.Width, kTitleContentRectHeight * (self.Height / 44.0));
    }
    
    return titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    if (self.Height > kTitleContentRectHeight) {
        CGFloat margin = kMargin;
        CGFloat imgHeight = self.Height - kTitleContentRectHeight - margin;
        imageRect = CGRectMake((self.Width - imgHeight - margin) * 0.5, 4, imgHeight, imgHeight);
    }
    
    return imageRect;
}

@end
