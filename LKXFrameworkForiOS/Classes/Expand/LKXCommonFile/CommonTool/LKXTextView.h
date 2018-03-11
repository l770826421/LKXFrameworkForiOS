//
//  LKXTextView.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/21.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 有提示语的TextView
 */
@interface LKXTextView : UITextView

/** 设置提示语句 */
@property (nonatomic, strong) NSString *placeholder;

@end
