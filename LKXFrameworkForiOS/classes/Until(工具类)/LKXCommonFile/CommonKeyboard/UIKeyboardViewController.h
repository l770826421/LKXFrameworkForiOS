//
//  UIKeyboardViewController.h
//
//
//  Created by  YFengchen on 13-1-4.
//  Copyright 2013 __zhongyan__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardView.h"

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]   //返回当前系统版本号

@protocol UIKeyboardViewControllerDelegate;

@interface UIKeyboardViewController : NSObject <UITextFieldDelegate, UIKeyboardViewDelegate, UITextViewDelegate> {
	CGRect keyboardBounds;
	UIKeyboardView *keyboardToolbar;
    id <UIKeyboardViewControllerDelegate> _boardDelegate;
    UIView *objectView;
}

@property (nonatomic, assign) id <UIKeyboardViewControllerDelegate> boardDelegate;

@end

@interface UIKeyboardViewController (UIKeyboardViewControllerCreation)

- (id)initWithControllerDelegate:(id <UIKeyboardViewControllerDelegate>)delegateObject;

@end

@interface UIKeyboardViewController (UIKeyboardViewControllerAction)

- (void)addToolbarToKeyboard;

@end

@protocol UIKeyboardViewControllerDelegate <NSObject>

@optional

- (BOOL)alttextFieldShouldBeginEditing:(UITextField *)textField;
- (void)alttextFieldDidEndEditing:(UITextField *)textField;
- (BOOL)alttextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;


- (BOOL)alttextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)alttextViewDidEndEditing:(UITextView *)textView;
- (void)alttextViewShouldBeginEditing:(UITextView *)textView;

@end
