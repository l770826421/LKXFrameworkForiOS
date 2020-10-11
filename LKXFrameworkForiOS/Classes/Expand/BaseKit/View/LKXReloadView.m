//
//  LKXReloadView.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXReloadView.h"
#import "Macros_UICommon.h"
#import "UIView+LKXBase.h"
#import "UIView+Common.h"

#define kMessageFontSize 20
#define kNetWorkErrorMessageText @"网络错误,请从新加载~~"
#define kNoDataMessageText @"您的数据为空~~"

@interface LKXReloadView ()

/** message提示Label */
@property (nonatomic, strong) UILabel *messageLabel;

/** 重新请求数据Button */
@property (nonatomic, strong) UIButton *relodButton;

@end

@implementation LKXReloadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Dev_ScreenWidth - 20 * 2, 200)];
    [self addSubview:view];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.lkx_width, 80)];
    self.messageLabel.textColor = [UIColor grayColor];
    self.messageLabel.font = [UIFont systemFontOfSize:kMessageFontSize];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.text = self.isNetWorkError ? kNetWorkErrorMessageText : kNoDataMessageText;
    [view addSubview:self.messageLabel];
    
    self.relodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.relodButton.frame = CGRectMake((view.lkx_width - 100 ) * 0.5, self.messageLabel.lkx_bottom + 8, 100, 40);
    [self.relodButton lkx_setBackgroundColor:[UIColor whiteColor] cornerRadius:4.0 borderWidth:1.0 borderColor:[UIColor lightGrayColor]];
    [self.relodButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [self.relodButton setTitleColor:[UIColor lightGrayColor]
                           forState:UIControlStateNormal];
    [self.relodButton addTarget:self
                         action:@selector(btnActionReload)
               forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.relodButton];
}

- (void)layoutSubviews {
    for (UIView *view in self.subviews) {
        view.center = self.center;
    }
}

/**
 *  @author 刘克邪
 *
 *  @brief  重新加载数据button
 */
- (void)btnActionReload {
    if ([self.delegate respondsToSelector:@selector(reloadViewDidTouchUpInside:)]) {
        [self.delegate reloadViewDidTouchUpInside:self];
    }
}



@end
