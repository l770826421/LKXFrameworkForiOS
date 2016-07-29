//
//  UIKeyboardView.m
//
//
//  Created by  YFengchen on 13-1-4.
//  Copyright 2013 __zhongyan__. All rights reserved.
//

#import "UIKeyboardView.h"


@implementation UIKeyboardView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		keyboardToolbar = [[UIToolbar alloc] initWithFrame:frame];
        keyboardToolbar.barTintColor=RGBCOLOR(212, 212, 212);
		keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
		
		UIBarButtonItem *previousBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"previous", @"前一项")
																			style:UIBarButtonItemStylePlain
																		   target:self
																		   action:@selector(toolbarButtonTap:)];
        //ui改造替换图片
        [previousBarItem setImage:[UIImage imageNamed:@"icon_login_left"]];
         previousBarItem.tintColor=RGBCOLOR(42,136,232);
		previousBarItem.tag=1;
      
		
		UIBarButtonItem *nextBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"next", @"后一项")
																		style:UIBarButtonItemStylePlain
																	   target:self
																	   action:@selector(toolbarButtonTap:)];
        
        //ui改造替换图片
        [nextBarItem setImage:[UIImage imageNamed:@"icon_login_right"]];
        nextBarItem.tintColor=RGBCOLOR(42,136,232);
		nextBarItem.tag=2;
		
		UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																					  target:nil
																					  action:nil];
		
		UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"done", @"完成")
																		style:UIBarButtonItemStylePlain
																	   target:self
																	   action:@selector(toolbarButtonTap:)];
		doneBarItem.tag=3;
        doneBarItem.tintColor=RGBCOLOR(42,136,232);
       
		
		[keyboardToolbar setItems:[NSArray arrayWithObjects:previousBarItem, nextBarItem, spaceBarItem, doneBarItem, nil]];
		[previousBarItem release];
		[nextBarItem release];
		[spaceBarItem release];
		[doneBarItem release];
		[self addSubview:keyboardToolbar];
		[keyboardToolbar release];
    }
    return self;
}

- (void)toolbarButtonTap:(UIButton *)button {
	if ([self.delegate respondsToSelector:@selector(toolbarButtonTap:)]) {
		[self.delegate toolbarButtonTap:button];
	}
}

@end

@implementation UIKeyboardView (UIKeyboardViewAction)

//根据index找出对应的UIBarButtonItem
- (UIBarButtonItem *)itemForIndex:(NSInteger)itemIndex {
	if (itemIndex < [[keyboardToolbar items] count]) {
		return [[keyboardToolbar items] objectAtIndex:itemIndex];
	}
	return nil;
}

@end
