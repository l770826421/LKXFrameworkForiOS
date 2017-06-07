//
//  LKXTextField.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 15-1-4.
//  Copyright (c) 2015年 cnmobi. All rights reserved.
//

#import "LKXTextField.h"

@implementation LKXTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//控制placeholder的位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y + 10.0f, bounds.size.width, bounds.size.height);
    return inset;
}

//控制placeholder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor whiteColor] setFill];
    //UITextAttributeTextColor/UITextAttributeTextShadowOffset/UITextAttributeFont
    [[self placeholder] drawInRect:rect withAttributes:@{
                                                        NSForegroundColorAttributeName : WHITECOLOR,
                                                        NSShadowAttributeName : [NSValue valueWithUIOffset:UIOffsetZero],
                                                        NSFontAttributeName : [UIFont boldSystemFontOfSize:17]
                                                         }];
}

@end
