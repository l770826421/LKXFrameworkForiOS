//
//  LKXImagePickerTool.h
//  malama_ca
//
//  Created by Developer on 15/4/15.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LKXImagePickerTool;

@protocol LKXImagePickerToolDelegate <NSObject>

@optional
/**
 *  @author 刘克邪
 *
 *  @brief  选中相片或拍照后的代理
 *
 *  @param image 选中相片或拍照后的相片
 */
- (void)imagePickerToolDidSelectedImage:(UIImage *)image;

@end

/**
 *  @author 刘克邪
 *
 *  @brief  调用手机相册或相机
 */
@interface LKXImagePickerTool : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *imagePickerVC;
    BOOL isTakePicture;
}


/**
 *  设置了delegate则BackPhotoBlock将会被注销,不能使用,二者选其一
 */
@property (nonatomic, weak) id<LKXImagePickerToolDelegate> delegate;

@property (nonatomic, copy) void (^BackPhotoBlock)(UIImage *image);

/**
 * 初始化一个UIImagePickerController的工具类
 * 只支持单拍和选择单张相片
 * @prameter isEditing 单拍活着选择相片后是否编辑
 */
- (instancetype)initWithEditing:(BOOL)isEditing;

/**
 * 拍照
 * @prameter dismissVC  推出UIImagePickerController的界面
 */
- (void)takePhotoWithVC:(UIViewController *)dismissVC;

/** 
 * 从相册中选择相片
 * @prameter dismissVC  推出UIImagePickerController的界面
 */
- (void)selectOnePhotoWithVC:(UIViewController *)dismissVC;
//- (void)selectMultiPhotoWithVC:(UIViewController *)delegateVC;

@end
