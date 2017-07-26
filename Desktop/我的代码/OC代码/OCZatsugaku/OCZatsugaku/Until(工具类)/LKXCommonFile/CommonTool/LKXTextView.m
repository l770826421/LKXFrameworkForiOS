//
//  LKXTextView.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXTextView.h"

@implementation LKXTextView

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)setText:(NSString *)text {
    
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
   
    CGFloat margin = 8;
    CGFloat top = 4;
    CGRect newRect = CGRectMake(margin, top, rect.size.width - margin * 2, rect.size.height - top * 2);
    [super drawRect:newRect];
    
    if (self.text.length > 0) {
        
    } else {
        newRect = CGRectMake(margin, top + 2, rect.size.width - margin * 2, rect.size.height - top * 2);
        [self.placeholder drawInRect:newRect withAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    }
}

- (void)contentChange:(NSNotification *)notifi {
    
    [self setNeedsDisplay];
}

@end
