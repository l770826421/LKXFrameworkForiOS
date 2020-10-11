//
//  UIView+LKXBase.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 2020/10/11.
//  Copyright © 2020 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LKXBase)

/** X坐标 */
@property (nonatomic, assign) CGFloat lkx_x;
/** y坐标 */
@property (nonatomic, assign) CGFloat lkx_y;
/** 最右边x坐标 */
@property (nonatomic, assign, readonly) CGFloat lkx_right;
/** 最底部y坐标 */
@property (nonatomic, assign, readonly) CGFloat lkx_bottom;
/** width */
@property (nonatomic, assign) CGFloat lkx_width;
/** height */
@property (nonatomic, assign) CGFloat lkx_height;
/** size */
@property(nonatomic, assign) CGSize lkx_size;
/** origin */
@property(nonatomic, assign) CGPoint lkx_origin;

@end

NS_ASSUME_NONNULL_END
