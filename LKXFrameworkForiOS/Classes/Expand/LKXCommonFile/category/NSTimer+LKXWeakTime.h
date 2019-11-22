//
//  NSTimer+LKXWeakTime.h
//  LKXTestDemo
//
//  Created by lkx on 9/10/2019.
//  Copyright © 2019 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (LKXWeakTime)

/// weak调用
+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END
