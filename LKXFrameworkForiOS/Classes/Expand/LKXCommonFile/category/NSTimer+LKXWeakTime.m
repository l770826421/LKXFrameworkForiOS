//
//  NSTimer+LKXWeakTime.m
//  LKXTestDemo
//
//  Created by lkx on 9/10/2019.
//  Copyright © 2019 刘克邪. All rights reserved.
//

#import "NSTimer+LKXWeakTime.h"

#import <UIKit/UIKit.h>

@interface LKXTimerWeakObjct : NSObject

/** 目标对象 */
@property(nonatomic, weak) id target;
/** 执行方法 */
@property(nonatomic, assign) SEL selector;
/** 定时器 */
@property(nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;

@end

@implementation LKXTimerWeakObjct

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#pragma clang diagnostic ignored "-Wunused-variable"
            [self.target performSelector:self.selector withObject:timer.userInfo];
        }
    } else {
        [self.timer invalidate];
    }
}

@end


@implementation NSTimer (LKXWeakTime)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)yesOrNo {
    LKXTimerWeakObjct *timerWeakObjct = [[LKXTimerWeakObjct alloc] init];
    timerWeakObjct.target = aTarget;
    timerWeakObjct.selector= aSelector;
    timerWeakObjct.timer = [NSTimer scheduledTimerWithTimeInterval:ti
                                                            target:timerWeakObjct
                                                          selector:@selector(fire:)
                                                          userInfo:userInfo
                                                           repeats:yesOrNo];
    return timerWeakObjct.timer;
}

@end
