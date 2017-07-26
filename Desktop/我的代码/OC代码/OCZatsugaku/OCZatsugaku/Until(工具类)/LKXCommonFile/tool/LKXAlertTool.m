//
//  LKXAlertTool.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/10/20.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXAlertTool.h"

@interface LKXAlertTool ()
{
    UIAlertController *_alertController;
#pragma clang diagostic ignored"-Wdeprecated-declarations"
    UIAlertView *_alertView;
    UIActionSheet *_actionSheet;
}

@end

@implementation LKXAlertTool

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - setter and getter
- (void)setStyle:(UIAlertControllerStyle)style {
    _style = style;
    if (style == UIAlertControllerStyleAlert) {
        if (Dev_IOSVersion < 9.0) {
//            #pragma clang diagostic ignored"-Wdeprecated-declarations"
            _alertView = [[UIAlertView alloc] initWithTitle:nil
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
        } else {
            _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
        }
        
    } else {
        if (Dev_IOSVersion < 8.3) {
//#pragma clang diagostic ignored"-Wdeprecated-declarations"
            _actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"cancel"
                                         destructiveButtonTitle:nil otherButtonTitles:nil];
        } else {
            _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
        }
    }
}

#pragma mark - show
/**
 显示提示框选择框
 */
- (void)show {
    if (self.style != UIAlertControllerStyleAlert && self.style != UIAlertControllerStyleActionSheet) {
        self.style = UIAlertControllerStyleAlert;
    }
    
    if (_style == UIAlertControllerStyleAlert) {
        if (Dev_IOSVersion < 9.0) {
            for (NSString *title in _titles) {
                NSAssert([title isKindOfClass:[NSString class]], @"titles的必须是由字符串组成的数组");
                [_alertView addButtonWithTitle:title];
            }
            _alertView.title = _title;
            _alertView.message = _message;
            _alertView.delegate = _showViewController;
            [_alertView show];
        } else {
            [self alertControllerShow];
        }
    } else {
        if (Dev_IOSVersion < 8.3) {
            for (NSString *title in _titles) {
                NSAssert([title isKindOfClass:[NSString class]], @"titles的必须是由字符串组成的数组");
                [_actionSheet addButtonWithTitle:title];
            }
            _actionSheet.title = _title;
            _actionSheet.delegate = _showViewController;
            [_actionSheet showInView:_showViewController.view.window];
        } else  {
            [self alertControllerShow];
        }
    }
}

- (void)alertControllerShow {
    _alertController.title = _title;
    _alertController.message = _message;
    __block LKXAlertTool *selfBlock = self;
    for (int i = 0; i < _titles.count; i++) {
        NSString *title = _titles[i];
        [_alertController addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([selfBlock.delegate respondsToSelector:@selector(alertTool:didSelectedIndex:)]) {
                [selfBlock.delegate alertTool:selfBlock didSelectedIndex:i];
            }
        }]];
    }
    
    [_showViewController presentViewController:_alertController animated:YES completion:nil];
}

@end
