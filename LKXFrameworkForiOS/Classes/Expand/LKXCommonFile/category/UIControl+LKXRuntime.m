//
//  UIControl+LKXRuntime.m
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/9/17.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "UIControl+LKXRuntime.h"
#import <objc/runtime.h>
#import "Macros_UICommon.h"

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

@implementation UIControl (LKXRuntime)

+ (void)load
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__lkx_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)setMethod
{
    Method a = class_getInstanceMethod(self.class, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self.class, @selector(__lkx_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)__lkx_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.lkx_ignoreEvent)
    {
        LKXMLog(@"1");
        return;
    }
    
    LKXMLog(@"0");
    [self __lkx_sendAction:action to:target forEvent:event];
    if (self.lkx_acceptEventInterval > 0)
    {
        self.lkx_ignoreEvent = YES;
        [self performSelector:@selector(setControlLkx_ignoreEvent:)
                   withObject:@(NO)
                   afterDelay:self.lkx_acceptEventInterval];
    }
}

- (void)setControlLkx_ignoreEvent:(id)obj
{
    BOOL lkx_ignoreEvent = [obj boolValue];
    self.lkx_ignoreEvent = lkx_ignoreEvent;
}

- (NSTimeInterval)lkx_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];;
}

- (void)setLkx_acceptEventInterval:(NSTimeInterval)lkx_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(lkx_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)lkx_ignoreEvent
{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

- (void)setLkx_ignoreEvent:(BOOL)lkx_ignoreEvent
{
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(lkx_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
