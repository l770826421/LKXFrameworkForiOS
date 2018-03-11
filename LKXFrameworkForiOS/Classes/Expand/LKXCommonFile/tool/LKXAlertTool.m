//
//  LKXAlertTool.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/10/20.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXAlertTool.h"

@interface LKXAlertTool () <UIAlertViewDelegate, UIActionSheetDelegate>
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
- (void)setStyle:(LKXAlertStyle)style {
    _style = style;
    if (style == LKXAlertStyleAlert) {
        if (Dev_IOSVersion < 8.0) {
//            #pragma clang diagostic ignored"-Wdeprecated-declarations"
            _alertView = [[UIAlertView alloc] init];
        } else {
            _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        }
        
    } else {
        if (Dev_IOSVersion < 8.0) {
//#pragma clang diagostic ignored"-Wdeprecated-declarations"
            _actionSheet = [[UIActionSheet alloc] init];
        } else {
            _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        }
    }
}

#pragma mark - show
/**
 显示提示框选择框
 */
- (void)show {
    if (self.style != LKXAlertStyleAlert && self.style != LKXAlertStyleActionSheet) {
        self.style = UIAlertControllerStyleAlert;
    }
    
    if (_style == LKXAlertStyleAlert) {
        if (Dev_IOSVersion < 8.0) {
            _alertView.title = _title;
            _alertView.message = _message;
            _alertView.delegate = self;
            for (NSString *title in _titles) {
//                NSAssert([title isKindOfClass:[NSString class]], @"titles的必须是由字符串组成的数组");
                if (!title || title.length == 0) {
                    continue;
                }
                [_alertView addButtonWithTitle:title];
            }
            _alertView.cancelButtonIndex = _titles.count - 1;
            [_alertView show];
        } else {
            [self alertControllerShow];
        }
    } else {
        if (Dev_IOSVersion < 8.0) {
            _actionSheet.title = _title;
            _actionSheet.delegate = self;
            for (NSString *title in _titles) {
//                NSAssert([title isKindOfClass:[NSString class]], @"titles的必须是由字符串组成的数组");
                if (!title || title.length == 0) {
                    continue;
                }
                [_actionSheet addButtonWithTitle:title];
            }
            _actionSheet.cancelButtonIndex = _titles.count - 1;
            [_actionSheet showInView:[UIApplication sharedApplication].keyWindow];
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
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        NSString *title = _titles[i];
        if (i == _titles.count - 1) {
            if (!_titles || title.length == 0) {
                continue;
            }
            style = UIAlertActionStyleCancel;
        }
        [_alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if ([selfBlock.delegate respondsToSelector:@selector(alertTool:didSelectedIndex:)]) {
                [selfBlock.delegate alertTool:selfBlock didSelectedIndex:i];
            }
        }]];
    }
    
    [_showViewController presentViewController:_alertController animated:YES completion:nil];
}

#pragma mark - UIAlertViewDelegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertTool:self didSelectedIndex:buttonIndex];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertTool:self didSelectedIndex:buttonIndex];
    }
}

@end
