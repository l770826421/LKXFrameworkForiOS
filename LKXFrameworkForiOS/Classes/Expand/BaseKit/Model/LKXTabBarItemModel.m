//
//  LKXTabbarItemModel.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 29/7/2019.
//  Copyright © 2019 刘克邪. All rights reserved.
//

#import "LKXTabBarItemModel.h"

@implementation LKXTabBarItemModel

/**
 初始化

 @param vcClass viewController类对象
 @param title 标题
 @param normalImageName 默认图片名称
 @param selectedImageName 选中图片名称
 */
- (instancetype)initWithViewController:(Class)vcClass
                                 title:(NSString *)title
                       normalImageName:(NSString *)normalImageName
                     selectedImageName:(NSString *)selectedImageName
{
    self = [super init];
    if (self) {
        self.viewController = [[vcClass alloc] init];
        self.title = title;
        self.normalImage = [UIImage imageNamed:normalImageName];
        self.selectedImage = [UIImage imageNamed:selectedImageName];
    }
    return self;
}

/**
 初始化
 
 @param vcClass viewController类对象
 @param title 标题
 @param normalImage 默认图片
 @param selectedImage 选中图片
 */
- (instancetype)initWithViewController:(Class)vcClass
                                 title:(NSString *)title
                           normalImage:(UIImage *)normalImage
                         selectedImage:(UIImage *)selectedImage
{
    self = [super init];
    if (self) {
        self.viewController = [[vcClass alloc] init];
        self.title = title;
        self.normalImage = normalImage;
        self.selectedImage = selectedImage;
    }
    return self;
}

@end
