//
//  LKXTabbarItemModel.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 29/7/2019.
//  Copyright © 2019 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKXTabBarItemModel : NSObject

/** View controller  */
@property(nonatomic, strong) UIViewController *viewController;
/** title */
@property(nonatomic, copy) NSString *title;
/** 默认图片 */
@property(nonatomic, strong) UIImage *normalImage;
/** 选中图片 */
@property(nonatomic, strong) UIImage *selectedImage;

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
                     selectedImageName:(NSString *)selectedImageName;

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
                         selectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
