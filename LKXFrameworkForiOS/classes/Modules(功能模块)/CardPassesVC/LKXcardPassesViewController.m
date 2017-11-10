//
//  LKXcardPassesViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/10/19.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXcardPassesViewController.h"
#import "LKXAlertTool.h"

#import <LocalAuthentication/LocalAuthentication.h>
#import "LKXTouchIDValidateTool.h"
#import "NSDate+LKXCategory.h"
#import "LKXWKWebViewController.h"
#import "LKXCalendarTool.h"
#import "UIImage+LKXHack.h"

#import "Masonry.h"

@interface LKXcardPassesViewController () <LKXAlertToolDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    NSArray *_titles;
}

@end

@implementation LKXcardPassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titles = @[@"title1", @"title2", @"title3", @"title4", @"cacel"];
    
    [self autolayoutScroll];
    self.scroll.backgroundColor = [UIColor greenColor];
    __weak typeof(self) selfWeak = self;
    
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor brownColor];
    [self.scroll addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.scroll);
        make.width.equalTo(selfWeak.scroll);
    }];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [container addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.width.equalTo(container);
        make.height.equalTo(@150);
    }];
    
    /**  两个并排的view */
    CGFloat padding = 10;
    UIView *subWhiteView = [[UIView alloc] init];
    subWhiteView.backgroundColor = [UIColor whiteColor];
    [redView addSubview:subWhiteView];
    
    UIView *subBlackView = [[UIView alloc] init];
    subBlackView.backgroundColor = [UIColor blackColor];
    [redView addSubview:subBlackView];
    
    __weak __typeof(redView) redViewWeak = redView;
    __weak __typeof(subWhiteView) subWhiteViewWeak = subWhiteView;
    __weak __typeof(subBlackView) subBlackViewWeak = subBlackView;
    [subWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 1.函数式编程:
        // equalTo(redViewWeak.mas_left)
        // offset(padding)
        // 2.链式编程
        // equalTo(redViewWeak.mas_left).with.offset(padding)
        make.centerY.mas_equalTo(redViewWeak.mas_centerY);
        make.left.equalTo(redViewWeak.mas_left).with.offset(padding);
        make.right.equalTo(subBlackViewWeak.mas_left).with.offset(-padding);
        make.width.equalTo(subBlackViewWeak);
        make.height.equalTo(redViewWeak.mas_height);
    }];
    
    [subBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(redViewWeak.mas_centerY);
        make.left.equalTo(subWhiteViewWeak.mas_right).with.offset(padding);
        make.right.equalTo(redViewWeak.mas_right).with.offset(-padding);
        make.width.equalTo(subWhiteViewWeak);
        make.height.equalTo(redViewWeak.mas_height);
    }];
    
    // 在subBlackView中添加一个button
    UIButton *calendarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [calendarButton setTitle:@"添加日历" forState:UIControlStateNormal];
    [calendarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    calendarButton.titleLabel.font = [UIFont systemFontOfSize:FONT_size12];
    [calendarButton addTarget:self
                   action:@selector(calendarAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [subBlackView addSubview:calendarButton];
    [calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [container addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView.mas_bottom).with.offset(padding);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.height.equalTo(@200);
    }];
    
    // 在subWhiteView中添加一个button
    UIButton *touchIDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchIDButton setTitle:@"touch ID 测试" forState:UIControlStateNormal];
    [touchIDButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    touchIDButton.titleLabel.font = [UIFont systemFontOfSize:FONT_size12];
    [touchIDButton addTarget:self
                      action:@selector(btnActionTouchID:)
            forControlEvents:UIControlEventTouchUpInside];
    [subWhiteView addSubview:touchIDButton];
    [touchIDButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    /** 居中显示 */
    UIButton *alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertBtn setTitle:@"弹出系统提示框" forState:UIControlStateNormal];
    [alertBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertBtn addTarget:self
                 action:@selector(btnActionShowAlert:)
       forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:alertBtn];
    [alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(whiteView);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    [container addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_bottom).with.offset(padding);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.height.equalTo(@200);
    }];
    
    /** 居中显示 */
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setTitle:@"推出WKWebView" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pushBtn addTarget:self
                 action:@selector(pushAction:)
       forControlEvents:UIControlEventTouchUpInside];
    [blueView addSubview:pushBtn];
    [pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(blueView);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
    
    UIView *blackView = [[UIView alloc] init];
    blackView.backgroundColor = [UIColor blackColor];
    [container addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blueView.mas_bottom).with.offset(padding);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.height.equalTo(@200);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"avatar"];
    [blackView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@20);
        make.width.height.equalTo(@100);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(blackView.mas_bottom);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LKXMLog(@"(x: %f, y: %f) -- (width: %f, height: %f)", blackView.lkx_left, blackView.lkx_top, blackView.lkx_width, blackView.lkx_height);
    });
    
    NSDate *date = [NSDate date];
    NSDateComponents *components = [date lkx_dateInfo];
    LKXMLog(@"date info : %@", components);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 其他 
- (void)btnActionShowAlert:(UIButton *)btn {
    LKXAlertTool *alertTool = [[LKXAlertTool alloc] init];
    alertTool.style = UIAlertControllerStyleAlert;
    alertTool.showViewController = self;
    alertTool.delegate = self;
    alertTool.title = @"测试alertTool";
    alertTool.message = @"测试bug。。。";
    alertTool.titles = _titles;
    [alertTool show];
}


/**
 测试touchID
 */
- (void)btnActionTouchID:(UIButton *)btn {
    [[LKXTouchIDValidateTool sharedTouchIDValidateTool] touchValidateSupportFailure:^(LAError errorCode) {
        // 不支持指纹识别,log出错误详情
        switch (errorCode) {
            case LAErrorTouchIDNotEnrolled:
                LKXMLog(@"Touch ID id not enrolled");
                break;
            case LAErrorPasscodeNotSet:
                LKXMLog(@"A passcode has not been set");
                break;
            default:
                LKXMLog(@"Touch ID not available");
                break;
        }
    } success:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 其他情况,切换主线程处理
            [kMBHUDTool showHUDWithText:@"Touch ID验证成功" delay:kMBHUDDelay];
        }];
    } validateFailure:^(LAError errorCode) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 其他情况,切换主线程处理
            [kMBHUDTool showHUDWithText:@"Touch ID验证失败" delay:kMBHUDDelay];
        }];
        switch (errorCode) {
            case LAErrorSystemCancel:
                LKXMLog(@"系统取消");
                break;
            case LAErrorUserCancel:
                LKXMLog(@"用户取消");
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // 用户选择输入密码,切换主线程处理
                }];
                break;
            default:
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // 其他情况,切换主线程处理
                }];
                break;
        }
    }];

    return;
    
    /*
    // 初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    NSString *result = @"我的Touch ID";

    // 先判断设备是否支持Touch ID
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // 支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // 其他情况,切换主线程处理
                    [kMBHUDTool showHUDWithText:@"Touch ID验证成功" delay:kMBHUDDelay];
                }];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // 其他情况,切换主线程处理
                    [kMBHUDTool showHUDWithText:@"Touch ID验证失败" delay:kMBHUDDelay];
                }];
                switch (error.code) {
                    case LAErrorSystemCancel:
                        LKXMLog(@"系统取消");
                        break;
                    case LAErrorUserCancel:
                        LKXMLog(@"用户取消");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                           // 用户选择输入密码,切换主线程处理
                        }];
                        break;
                    default:
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            // 其他情况,切换主线程处理
                        }];
                        break;
                }
            }
        }];
    } else {    // 不支持指纹识别,log出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
                LKXMLog(@"Touch ID id not enrolled");
                break;
            case LAErrorPasscodeNotSet:
                LKXMLog(@"A passcode has not been set");
                break;
            default:
                LKXMLog(@"Touch ID not available");
                break;
        }
    }
     */
}

#pragma mark - UIAlertToolDelegate 
- (void)alertTool:(LKXAlertTool *)alertTool didSelectedIndex:(NSInteger)index {
    LKXMLog(@"--------%@", _titles[index]);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    LKXMLog(@"--------%@", _titles[buttonIndex]);
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    LKXMLog(@"--------%@", _titles[buttonIndex]);
}

- (void)pushAction:(UIButton *)btn {
    LKXWKWebViewController *vc = [[LKXWKWebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)calendarAction:(UIButton *)btn {
    LKXCalendarTool *calendarTool = [[LKXCalendarTool alloc] init];
    EKEvent *event = [calendarTool createEvent];
    event.title = @"测试";
    [calendarTool writeDataWithEvent:event success:^(BOOL success) {
        if (success) {
            LKXMLog(@"添加时间到日历成功");
        }
    }];
}

@end
