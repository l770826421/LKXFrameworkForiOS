//
//  UIButton+Categoty.m
//  MyCategory
//
//  Created by lkx on 14-11-27.
//  Copyright (c) 2014年 cnmobi. All rights reserved.
//

#import "UIButton+categoty.h"

@implementation UIButton (Categoty)

/*
 * *给button添加角标
 */
- (void)addCorner
{
    UILabel *cornerLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.lkx_width - 17.0f, self.lkx_top - 15.0f, 25.0f, 25.0f)];
    [cornerLbl setBackgroundColor:REDCOLOR cornerRadius:13.0f borderWidth:0 borderColor:CLEARCOLOR];
    cornerLbl.textColor = WHITECOLOR;
    cornerLbl.font = FontSize(12);
    cornerLbl.tag = 10000;
    cornerLbl.textAlignment = NSTextAlignmentCenter;
    cornerLbl.clipsToBounds = YES;
    cornerLbl.hidden = YES;
    [self addSubview:cornerLbl];
}

/*
 * 给角标设置内容
 */
- (void)setCornerContent:(int)number
{
    UILabel *cornerLbl;
    for (UIView *subView in self.subviews)
    {
        if (subView.tag == 10000)
        {
            cornerLbl = (UILabel *)subView;
        }
    }
    
    NSString *str;
    if (number <= 0)
    {
        cornerLbl.hidden = YES;
        str = @"";
        cornerLbl.text = str;
        return;
    }
    else if (number < 100)
    {
        str = [NSString stringWithFormat:@"%d", number];
    }
    else if (number >= 100)
    {
        str = @"99+";
    }

    cornerLbl.hidden = NO;
    cornerLbl.text = str;
}

@end
