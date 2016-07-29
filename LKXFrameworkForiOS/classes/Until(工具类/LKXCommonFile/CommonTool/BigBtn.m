//
//  BigBtn.m
//  Kido
//
//  Created by zhaoyd on 14-6-27.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "BigBtn.h"

@implementation BigBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    
    CGFloat widthDelta;
    //设置热点大小
    if (bounds.size.width < 30.0)
    {
        widthDelta = MAX(30.0 - bounds.size.width, 0);
    }
    else
    {
        // 若原热区小于44 * 44，则放大热区到44，否则保持大小不变
        widthDelta = MAX(44.0 - bounds.size.width, 0);
    }
    
    CGFloat heightDelta;
    if (bounds.size.height < 30.0)
    {
        heightDelta = MAX(30.0 - bounds.size.height, 0);
    }
    else
    {
        // 若原热区小于44 * 44，则放大热区到44，否则保持大小不变
        heightDelta = MAX(44.0 - bounds.size.height, 0);
    }
    
    //设置热点区域
    bounds = CGRectInset(bounds, - 0.25 * widthDelta, - 0.25 *heightDelta);
    
    // point在拓展的bounds区域内，则返回yes
    return CGRectContainsPoint(bounds, point);
}

@end
