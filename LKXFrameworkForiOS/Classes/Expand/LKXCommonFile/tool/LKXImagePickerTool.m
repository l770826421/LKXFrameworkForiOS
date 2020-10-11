//
//  LKXImagePickerTool.m
//  malama_ca
//
//  Created by Developer on 15/4/15.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "LKXImagePickerTool.h"
#import "Macros_UICommon.h"
#import "LKXAPPDefine.h"

@implementation LKXImagePickerTool
{
    BOOL isTakePhoto;
}


- (instancetype)initWithEditing:(BOOL)isEditing
{
    self = [super init];
    if (self)
    {
        if (imagePickerVC == nil)
        {
            imagePickerVC = [[UIImagePickerController alloc] init];
            imagePickerVC.delegate = self;
            imagePickerVC.allowsEditing = isEditing;
        }
    }
    return self;
}

- (void)initializationImagePicker
{
    if (imagePickerVC == nil)
    {
        imagePickerVC = [[UIImagePickerController alloc] init];
        imagePickerVC.delegate = self;
//        imagePickerVC.allowsEditing = isEditing;
    }
}

//拍照
- (void)takePhotoWithVC:(UIViewController *)dismissVC
{
//    [self initializationImagePicker];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        [kMBHUDTool showHUDWithText:@"这设备不支持拍照功能" detailText:nil delay:2.0];
        return;
    }
    
    // 1.初始化捕捉设备(AVCaptureDevice),类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    if (!input)
    {
        [kMBHUDTool showHUDWithText:@"您关闭了拍照功能,请到设置中去开启" detailText:nil  delay:2.0];
        return;
    }
    
    isTakePhoto = YES;
    [dismissVC presentViewController:imagePickerVC animated:YES completion:nil];
}

/**
 * 从相册中选择相片
 * @prameter dismissVC  推出UIImagePickerController的界面
 */
- (void)selectOnePhotoWithVC:(UIViewController *)dismissVC
{
//    [self initializationImagePicker];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
    {
        [kMBHUDTool showHUDWithText:@"本设备不支持相册功能" detailText:nil delay:2.0];
        return;
    }
    isTakePhoto = NO;
    [dismissVC presentViewController:imagePickerVC animated:YES completion:nil];
}

//保存到图片回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)err contextInfo:(void *)context
{
    if (err != nil)
    {
        NSLog(@"保存图片失败");
    }
    else
    {
        NSLog(@"保存图片成功");
    }
}

#pragma mark - 
#pragma mark ========================= UIImagePickerControllerDelegate ============
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    LKXMLog(@"info == %@", info);
    UIImage *image;
    if (picker.allowsEditing)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    else
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (isTakePhoto)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        if ([self.delegate respondsToSelector:@selector(imagePickerToolDidSelectedImage:)]) {
            [self.delegate imagePickerToolDidSelectedImage:image];
        } else if (self.BackPhotoBlock)
        {
            self.BackPhotoBlock(image);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
