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
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    } else {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
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
    
    [self alertControllerShow];
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

@end
