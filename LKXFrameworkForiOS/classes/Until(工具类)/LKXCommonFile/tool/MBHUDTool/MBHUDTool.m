//
//  MBHUDTool.m
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/4/8.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "MBHUDTool.h"
#import "AppDelegate.h"

const CGFloat kMBHUDDelay = 1.0;
const CGFloat kAfterDelay = 1.0;

@interface MBHUDTool()

/** MBProgressHUD实例化对象,只初始化一次 */
@property(nonatomic, strong) MBProgressHUD *mbHud;

@end

@implementation MBHUDTool

single_implementation(MBHUDTool)

//创建MBProgressHUD实例
- (void)implementMBHUD
{
    _mbHud = [MBProgressHUD showHUDAddedTo:[kAppDelegate window] animated:YES];
    _mbHud.opaque = YES;
    _mbHud.delegate = self;
}



/**
 显示提示文字
 */
- (void)showHUDWithText:(NSString *)text
             detailText:(NSString *)detailText {
    [self showHUDWithText:text detailText:detailText delay:kMBHUDDelay];
}


/**
 显示提示文字
 */
- (void)showHUDWithText:(NSString *)text
             detailText:(NSString *)detailText
                  delay:(NSTimeInterval)delay {
    [self implementMBHUD];
    
    _mbHud.mode = MBProgressHUDModeText;
    
    if (text.length > 0) {
        _mbHud.label.text = text;
    } else {
        _mbHud.label.text = nil;
    }
    
    if (detailText > 0) {
        _mbHud.detailsLabel.text = detailText;
    } else {
        _mbHud.detailsLabel.text = nil;
    }

    if (delay <= 0) {
        [_mbHud hideAnimated:YES afterDelay:kAfterDelay];
    } else {
        [_mbHud hideAnimated:YES afterDelay:delay];
    }
}


/**
 显示一个数据加载的动画,小菊花(默认提示语加载中)
 */
- (void)showActivityIndicatorWithText:(NSString *)text
                           detailText:(NSString *)detailText {
    [self implementMBHUD];
    _mbHud.mode = MBProgressHUDModeIndeterminate;
    
    if (text.length > 0) {
        _mbHud.label.text = text;
    } else {
        _mbHud.label.text = nil;
    }
    
    if (detailText.length > 0) {
        _mbHud.detailsLabel.text = detailText;
    } else {
        _mbHud.detailsLabel.text = kLocalizedString(@"加载中...");
    }
}


//显示一个圆环加载
- (void)showAnnularWithText:(NSString *)text
                 detailText:(NSString *)detailText
{
    [self implementMBHUD];
    _mbHud.mode = MBProgressHUDModeAnnularDeterminate;
    
    if (text.length > 0) {
        _mbHud.label.text = text;
    } else {
        _mbHud.label.text = nil;
    }
    
    if (detailText.length > 0) {
        _mbHud.detailsLabel.text = detailText;
    } else {
        _mbHud.detailsLabel.text = kLocalizedString(@"加载中...");
    }
}

/**
 显示一个自定义的提示view
 
 @param view 提示view,传入的view的frame要确定
 */
- (void)showCustomView:(UIView *)view
                 delay:(NSTimeInterval)delay {
    [self implementMBHUD];
    _mbHud.mode = MBProgressHUDModeCustomView;
    _mbHud.customView = view;
    _mbHud.detailsLabel.text = nil;
    _mbHud.label.text = nil;
    
    [_mbHud hideAnimated:YES afterDelay:delay];
}

//一个横向的进度条
- (void)showHorizontalBarWithText:(NSString *)text
                       detailText:(NSString *)detailText {
    [self implementMBHUD];
    _mbHud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    if (text.length > 0) {
        _mbHud.label.text = text;
    } else {
        _mbHud.label.text = nil;
    }
    
    if (detailText.length > 0) {
        _mbHud.detailsLabel.text = detailText;
    } else {
        _mbHud.detailsLabel.text = kLocalizedString(@"加载中...");
    }
}

//显示一个圆圈加载
- (void)showDeterminateWithText:(NSString *)text
                     detailText:(NSString *)detailText {
    [self implementMBHUD];
    _mbHud.mode = MBProgressHUDModeDeterminate;
    
    if (text.length > 0) {
        _mbHud.label.text = text;
    } else {
        _mbHud.label.text = nil;
    }
    
    if (detailText.length > 0) {
        _mbHud.detailsLabel.text = detailText;
    } else {
        _mbHud.detailsLabel.text = kLocalizedString(@"加载中...");
    }
}

//隐藏一处MBProgressHUD
- (void)hideMBHUD:(BOOL)animated
{
    if (_mbHud != nil && ![_mbHud isHidden])
    {
        [_mbHud hideAnimated:animated];
    }
}

//判断MBHUD是否存在
- (BOOL)isShow
{
    if (_mbHud != nil)
    {
        return NO;
    }
    return YES;
}

// 判断MBHUD是否隐藏
- (BOOL)isHidden {
    return _mbHud.isHidden;
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud)
    {
        hud.label.text = nil;
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
