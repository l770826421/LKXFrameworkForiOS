//
//  LKXBarButton.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/5/6.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXBarButton.h"

#define kButtonProportion (self.lkx_height / 44.0)
#define kMargin 4
#define kTitleContentRectHeight (18.0 * kButtonProportion)

@implementation LKXBarButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    if (self.lkx_height > kTitleContentRectHeight) {
        
        titleRect = CGRectMake(0, self.lkx_height - kTitleContentRectHeight, self.lkx_width, kTitleContentRectHeight * (self.lkx_height / 44.0));
    }
    
    return titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    if (self.lkx_height > kTitleContentRectHeight) {
        CGFloat margin = kMargin;
        CGFloat imgHeight = self.lkx_height - kTitleContentRectHeight - margin;
        imageRect = CGRectMake((self.lkx_width - imgHeight - margin) * 0.5, 4, imgHeight, imgHeight);
    }
    
    return imageRect;
}

@end
