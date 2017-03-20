//
//  LKXAlertView.h
//  Test
//
//  Created by cnmobi1 on 14-4-29.
//  Copyright (c) 2014年 SZICBC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ARGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface LKXAlertView : UIView
{
    CGFloat         AltViewHight;
    CGFloat         AltViewWidth;
    
    UIView          *BGView;
    UIView          *AlirtView;
    UILabel         *titleLabel;
    UILabel         *messageLabel;
    UIButton        *cancelButton;
    UIButton        *otherButton;
    UILabel         *line01;
    UILabel         *line02;
    
}


@property(nonatomic,assign) id delegate;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(void)show;
-(void)showInView:(UIView *)SuperView;

@end

@protocol LKXAlertViewDelegate <NSObject>
@optional

- (void)LKXAlertView:(LKXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end



