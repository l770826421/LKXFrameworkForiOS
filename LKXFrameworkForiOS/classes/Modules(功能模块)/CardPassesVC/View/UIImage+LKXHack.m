//
//  UIImage+LKXHack.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/11/10.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "UIImage+LKXHack.h"
#import <objc/runtime.h>

@implementation UIImage (LKXHack)

+ (void)load {
    // 1.获取UIImageView类的实例方法'setImage:'
    Method originMethod = class_getInstanceMethod([self class], @selector(setImage:));
    // 2.获取UIImageView类的是来方法'lkx_setImage',本身定义在分类中
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(lkx_setImage:));
    // 3.交换setImage和lkx_setImage,交换完成之后
    // 1> 调用setImage相当于调用lkx_setImage
    // 2> 调用lkx_setImage相当于调用 setImage
    method_exchangeImplementations(originMethod, swizzledMethod);
}

- (void)lkx_setImage:(UIImage *)image {
    NSLog(@"%s", __FUNCTION__);
    
    [self lkx_setImage:image];
}

@end
