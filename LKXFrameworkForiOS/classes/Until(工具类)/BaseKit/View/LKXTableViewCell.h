//
//  LKXTableViewCell.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/3/22.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKXTableViewCell : UITableViewCell

/**
 *  @author 刘克邪
 *
 *  @brief  对tableView注册cell,indentifier为自己的类名字符串
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
