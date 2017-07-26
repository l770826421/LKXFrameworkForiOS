//
//  MBHUDTool.m
//  malama_ca
//
//  Created by Developer on 15/4/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "MBHUDTool.h"
#import "AppDelegate.h"

const CGFloat kMBHUDDelay = 1.0;
const CGFloat kAfterDelay = 1.0;

@implementation MBHUDTool
{
    MBProgressHUD *mbHud;
}

single_implementation(MBHUDTool)

//创建MBProgressHUD实例
- (void)implementMBHUD
{
    if (mbHud)
    {
        //存在时隐藏
        [mbHud hide:NO];
    }
    else
    {
        //如果不存在,就实例化
        mbHud = [[MBProgressHUD alloc] initWithView:[kAppDelegate window]];
        mbHud.opaque = YES;
        mbHud.delegate = self;
    }
}

//显示MBProgressHUD正在加载,并提示文字
- (void)showHUDWithText:(NSString *)text
{
    [self implementMBHUD];
    
    if (text.length > 0)
    {
        mbHud.labelText = text;
    }
    else
    {
        mbHud.labelText = nil;
    }
    
    mbHud.mode = MBProgressHUDModeIndeterminate;
    mbHud.dimBackground = NO;
    [[kAppDelegate window] addSubview:mbHud];
    [mbHud show:YES];
}

//显示delay秒钟的MBProgressHUD文字提示
- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay
{
    [self implementMBHUD];
    
    mbHud.mode = MBProgressHUDModeText;
    if (text.length > 0)
    {
        mbHud.detailsLabelText = text;
    }
    else
    {
        mbHud.detailsLabelText = nil;
    }
    mbHud.dimBackground = NO;
    [[kAppDelegate window] addSubview:mbHud];
    [mbHud show:YES];
    if (delay <= 0)
    {
        [mbHud hide:YES afterDelay:kAfterDelay];
    }
    else
    {
        [mbHud hide:YES afterDelay:delay];
    }
}

//显示一个数据加载的动画,小菊花
- (void)showActivityIndicator
{
    [self implementMBHUD];
    mbHud.mode = MBProgressHUDModeIndeterminate;
    mbHud.detailsLabelText = kLocalizedString(@"加载中...");
    mbHud.dimBackground = NO;
    [[kAppDelegate window] addSubview:mbHud];
    [mbHud show:YES];
    
    [mbHud hide:YES afterDelay:60];
}


//显示一个圆环加载
- (void)showAnnular
{
    [self implementMBHUD];
    mbHud.mode = MBProgressHUDModeAnnularDeterminate;
    mbHud.detailsLabelText = kLocalizedString(@"加载中...");
    mbHud.dimBackground = NO;
    [[kAppDelegate window] addSubview:mbHud];
    [mbHud showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f)
        {
            progress += 0.01f;
            mbHud.progress = progress;
            usleep(5000);
        }
    } completionBlock:^{
        [self hideMBHUD:YES];
    }];
}

/**
 显示一个自定义的提示view
 
 @param view 提示view,传入的view的frame要确定
 */
- (void)showCustomView:(UIView *)view {
    [self implementMBHUD];
    mbHud.mode = MBProgressHUDModeCustomView;
    mbHud.customView = view;
    mbHud.detailsLabelText = nil;
    mbHud.labelText = nil;
    mbHud.dimBackground = NO;
    [[kAppDelegate window] addSubview:mbHud];
    [mbHud show:YES];
    
    [mbHud hide:YES afterDelay:kAfterDelay];
}

//一个横向的进度条
- (void)showHorizontalBar
{
    [self implementMBHUD];
    mbHud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    mbHud.detailsLabelText = kLocalizedString(@"加载中...");
    mbHud.dimBackground = NO;
    [[kAppDelegate window] addSubview:mbHud];
    [mbHud showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            mbHud.progress = progress;
            usleep(5000);
        }
    } completionBlock:^{
        [self hideMBHUD:YES];
    }];
}

//显示一个圆圈加载
- (void)showDeterminate
{
    [self implementMBHUD];
    mbHud.mode = MBProgressHUDModeDeterminate;
    mbHud.detailsLabelText = kLocalizedString(@"加载中...");
    mbHud.dimBackground = NO;
    [[kAppDelegate window] addSubview:mbHud];
    [mbHud showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            mbHud.progress = progress;
            usleep(5000);
        }
    } completionBlock:^{
        [self hideMBHUD:YES];
    }];
}

//隐藏一处MBProgressHUD
- (void)hideMBHUD:(BOOL)animated
{
    if (mbHud != nil && ![mbHud isHidden])
    {
        [mbHud hide:animated];
    }
}

//判断MBHUD是否存在
- (BOOL)isShow
{
    if (mbHud != nil)
    {
        return NO;
    }
    return YES;
}

// 判断MBHUD是否隐藏
- (BOOL)isHidden {
    return mbHud.isHidden;
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud)
    {
        hud.labelText = nil;
        [hud removeFromSuperview];
        hud = nil;
    }
    
}

#pragma mark - 非MBProgressHUD
/**
 *  显示一些信息在2.5秒后消失
 *
 *  @param tips 显示的字符串
 */
+ (void)messageLabelTips:(NSString *)tips
{
    CGSize textSize = {200, 500};
    CGSize size = [tips boundingRectWithSize:textSize
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]}
                                     context:nil].size;
    CGSize centerSize = [[UIApplication sharedApplication] keyWindow].bounds.size;
    
    UILabel *showLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width + 40, size.height + 20)];
    [showLbl setBackgroundColor:[UIColor grayColor]];
    [showLbl setNumberOfLines:0];
    [showLbl.layer setCornerRadius:4];
    [showLbl.layer setBorderWidth:1];
    [showLbl.layer setBorderColor:RGBACOLOR(100, 100, 100, 1).CGColor];
    [showLbl setTextAlignment:NSTextAlignmentCenter];
    [showLbl setFont:[UIFont systemFontOfSize:14]];
    [showLbl setTextColor:[UIColor whiteColor]];
    
    [showLbl setCenter:CGPointMake(centerSize.width, centerSize.height)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:showLbl];
    
    showLbl.hidden = NO;
    showLbl.text = tips;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [showLbl removeFromSuperview];
        });
    });
}

@end
