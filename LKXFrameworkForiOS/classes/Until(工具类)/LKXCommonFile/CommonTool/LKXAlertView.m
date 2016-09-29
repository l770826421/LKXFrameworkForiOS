//
//  LKXAlertView.m
//  Test
//
//  Created by cnmobi1 on 14-4-29.
//  Copyright (c) 2014年 SZICBC. All rights reserved.
//


//  This File need  -fobjc-arc

#import "LKXAlertView.h"

@implementation LKXAlertView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        AltViewHight    = 20.0;
        AltViewWidth    = 270.0;
    }
    return self;
}



-(void)CreateAlertViewInit
{
    AltViewHight    = 0.0;
    AltViewWidth    = 270.0;
    
    BGView = [[UIView alloc]initWithFrame:self.bounds];
    [BGView setBackgroundColor:[UIColor blackColor]];
    [BGView setAlpha:0.4];
    [self addSubview:BGView];
    
    
    AlirtView = [[UIView alloc]initWithFrame:CGRectZero];
    [AlirtView setBackgroundColor:ARGB(230, 230, 230, 1.0)];
    [AlirtView.layer setCornerRadius:8.0];
    [AlirtView.layer setBorderWidth:0.2];
    [AlirtView.layer setBorderColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2].CGColor];
    [self addSubview:AlirtView];
    
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:18.0]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setNumberOfLines:0];
    
    
    messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [messageLabel setFont:[UIFont systemFontOfSize:14.0]];
    [messageLabel setTextColor:[UIColor blackColor]];
    [messageLabel setTextAlignment:NSTextAlignmentCenter];
    [messageLabel setNumberOfLines:0];
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTintColor:ARGB(35, 140, 235, 1.0)];
    [cancelButton setTitleColor:ARGB(35, 140, 235, 1.0) forState:UIControlStateNormal];
    [cancelButton setTitleColor:ARGB(60, 120, 250, 1.0) forState:UIControlStateHighlighted];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [cancelButton setTag:0];
    [cancelButton addTarget:self
                     action:@selector(TouchUpInsideFuncation:)
           forControlEvents:UIControlEventTouchUpInside];
    
    
    otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherButton setBackgroundColor:[UIColor clearColor]];
    [otherButton setTintColor:ARGB(35, 140, 235, 1.0)];
    [otherButton setTitleColor:ARGB(35, 140, 235, 1.0) forState:UIControlStateNormal];
    [otherButton setTitleColor:ARGB(60, 120, 250, 1.0) forState:UIControlStateHighlighted];
    [otherButton.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:17.0]];
    [otherButton setTag:1];
    [otherButton addTarget:self
                    action:@selector(TouchUpInsideFuncation:)
          forControlEvents:UIControlEventTouchUpInside];
    
    
    
    line01 = [[UILabel alloc]init];
    [line01 setBackgroundColor:[UIColor grayColor]];
    [line01 setAlpha:0.6];
    
    
    line02 = [[UILabel alloc]init];
    [line02 setBackgroundColor:[UIColor grayColor]];
    [line02 setAlpha:0.6];
    
    
    [AlirtView addSubview:titleLabel];
    [AlirtView addSubview:messageLabel];
    [AlirtView addSubview:cancelButton];
    [AlirtView addSubview:otherButton];
    [AlirtView addSubview:line01];
    [AlirtView addSubview:line02];
    
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    if (self) {
        self = [self initWithFrame:[UIScreen mainScreen].bounds];
        [self setBackgroundColor:[UIColor clearColor]];
        [self CreateAlertViewInit];
    }
    
    _delegate = delegate;
    
    CGFloat texthight = [self GetStringHight:title
                             andRectWithSize:CGSizeMake(AltViewWidth - 30, 300)
                                 andFontSize:18.0];
    if (title.length !=0) {
        [titleLabel setText:title];
        [titleLabel setFrame:CGRectMake(15, 10, AltViewWidth - 30, texthight)];
    }
    else
    {
        [titleLabel setFrame:CGRectMake(0, 10, 0, 0)];
    }
    AltViewHight = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    
    
    texthight = 20 + [self GetStringHight:message
                          andRectWithSize:CGSizeMake(AltViewWidth - 30, 300)
                              andFontSize:14.0];
    if (message.length !=0) {
        [messageLabel setText:message];
        [messageLabel setFrame:CGRectMake(15, AltViewHight, AltViewWidth - 30, texthight)];
    }
    else
    {
        [messageLabel setFrame:CGRectMake(15, 0, AltViewWidth - 30, texthight)];
    }
    AltViewHight = AltViewHight + messageLabel.frame.size.height + 10;
    
    if (cancelButtonTitle.length !=0) {
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    else{
        [cancelButton setTitle:NSLocalizedString(@"Cancel", @"取消") forState:UIControlStateNormal];
        [cancelButton setFrame:CGRectMake(0, AltViewHight, AltViewWidth, 44)];
    }
    if (otherButtonTitles.length !=0) {
        [otherButton    setTitle:otherButtonTitles forState:UIControlStateNormal];
        [cancelButton   setFrame:CGRectMake(0, AltViewHight, AltViewWidth/2, 44)];
        [otherButton    setFrame:CGRectMake(AltViewWidth/2, AltViewHight, AltViewWidth/2, 44)];
    }
    else
    {
        [otherButton    setTitle:otherButtonTitles forState:UIControlStateNormal];
        [cancelButton   setFrame:CGRectMake(0, AltViewHight, AltViewWidth, 44)];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:18.0]];
        [otherButton    setFrame:CGRectMake(AltViewWidth, AltViewHight, 0, 0)];
    }
    

    [line01 setFrame:CGRectMake(0, AltViewHight, AltViewWidth, 0.5)];
    if (otherButtonTitles.length != 0)
        [line02 setFrame:CGRectMake(AltViewWidth/2, AltViewHight, 0.5, 44.0)];
    else
        [line02 setFrame:CGRectZero];
    
    AltViewHight = AltViewHight + cancelButton.frame.size.height;

    [AlirtView setFrame:CGRectMake(0, 0, AltViewWidth, AltViewHight)];
    [AlirtView setCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)];
    
    return self;
}


-(void)show
{
    UIWindow *MainWindow = [[UIApplication sharedApplication] keyWindow];
    if (MainWindow.tag == 0) {
        [MainWindow addSubview:self];
        [MainWindow setTag:10];
    }
    
    [AlirtView setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    [AlirtView setAlpha:0.5];
    [BGView    setAlpha:0.0];
    [UIView animateWithDuration:0.3 animations:^{
        [AlirtView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        [AlirtView setAlpha:1.0];
        [BGView    setAlpha:0.4];
    }];
}

-(void)showInView:(UIView *)SuperView
{
    [SuperView addSubview:self];
    
    [AlirtView setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    [AlirtView setAlpha:0.5];
    [BGView     setAlpha:0.0];
    [UIView animateWithDuration:0.3 animations:^{
        [AlirtView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        [AlirtView setAlpha:1.0];
        [BGView    setAlpha:0.4];
    }];
}


-(void)TouchUpInsideFuncation:(UIButton *)button
{
    if (_delegate&&[_delegate respondsToSelector:@selector(LKXAlertView:clickedButtonAtIndex:)]) {
        [_delegate LKXAlertView:self clickedButtonAtIndex:button.tag];
    }
    
    UIWindow *MainWindow = [[UIApplication sharedApplication] keyWindow];
    [MainWindow setTag:0];
    
    [UIView animateWithDuration:0.2 animations:^{
        [AlirtView  setTransform:CGAffineTransformMakeScale(0.9, 0.9)];
        [AlirtView  setAlpha:0.0];
        [BGView     setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


-(float)GetStringHight:(NSString *)TextContent
       andRectWithSize:(CGSize)TextSize
           andFontSize:(CGFloat)FontSize
{
    float Hight = 0;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
//        CGSize Size = [TextContent sizeWithFont:[UIFont boldSystemFontOfSize:FontSize] constrainedToSize:TextSize lineBreakMode:NSLineBreakByWordWrapping];
        CGSize Size = [TextContent boundingRectWithSize:TextSize
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:FontSize]}
                                             context:nil].size;
        Hight = Size.height;
    }
    else
    {
        NSDictionary *ContentDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:FontSize],
                                     NSFontAttributeName,
                                     [UIColor blackColor],
                                     NSForegroundColorAttributeName,
                                     nil];
        CGRect Rect = [TextContent boundingRectWithSize:TextSize
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             attributes:ContentDict
                                                context:nil];
        Hight = Rect.size.height;
    }
    
    return Hight;
}


@end
