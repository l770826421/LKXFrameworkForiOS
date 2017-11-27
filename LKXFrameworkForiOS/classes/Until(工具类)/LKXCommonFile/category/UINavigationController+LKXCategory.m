//
//  UINavigationController+LKXCategory.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/11/15.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "UINavigationController+LKXCategory.h"
#import <objc/runtime.h>

@interface LKXFullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

/** 导航控制器 */
@property(nonatomic, weak) UINavigationController *navigationController;

@end

@implementation LKXFullScreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 如果是rootViewController就不需要返回上一层
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    // 如果正在转场动画,取消手势
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    // 判断手指方向,如果从左向右则相应
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

@end

@implementation UINavigationController (LKXCategory)

+ (void)load {
    Method originMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(lkx_pushViewController:animated:));
    
    method_exchangeImplementations(originMethod, swizzledMethod);
}


- (void)lkx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.lkx_popGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.lkx_popGestureRecognizer];
        
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        self.lkx_popGestureRecognizer.delegate = [self lkx_fullScreenPopGestureRecognizerDelegate];
        [self.lkx_popGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // 禁用系统的交互手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // 调用pushViewController:animated:
    if (![self.viewControllers containsObject:viewController]) {
        [self lkx_pushViewController:viewController animated:YES];
    }
}

- (LKXFullScreenPopGestureRecognizerDelegate *)lkx_fullScreenPopGestureRecognizerDelegate {
    LKXFullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[LKXFullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIPanGestureRecognizer *)lkx_popGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

@end
