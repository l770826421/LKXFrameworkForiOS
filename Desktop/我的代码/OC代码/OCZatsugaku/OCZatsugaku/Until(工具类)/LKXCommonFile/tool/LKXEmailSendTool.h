//
//  LKXEmailSendTool.h
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/5/22.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKXEmailSendTool : NSObject

/**
 *  @author 刘克邪
 *
 *  @brief  判断是否能启动邮件
 *
 */
+ (BOOL)canSendEmail;

/**
 *  直接调用系统邮件app发送
 *
 *  @param recipients    收件人数组
 *  @param ccRecipients  抄送人数组
 *  @param bccRecipients 密送人数组
 *  @param theme         邮件主题
 *  @param body          邮件内容
 */
+ (void)systemSendEmailWithRecipients:(NSArray *)recipients
                      andCcRecipients:(NSArray *)ccRecipients
                     andBccRecipients:(NSArray *)bccRecipients
                             addTheme:(NSString *)theme
                              addBody:(NSString *)body;

/**
 *  用MFMailComposeViewController发送邮件
 *
 *  @param recipients    收件人数组
 *  @param ccRecipients  抄送人数组
 *  @param bccRecipients 密送人数组
 *  @param theme         邮件主题
 *  @param body          邮件内容
 *  @param paths         附件数组
 *  @param delegate      dalegate的UIViewController
 */
+ (void)mailComposeSendEmailWithRecipients:(NSArray *)recipients
                           andCcRecipients:(NSArray *)ccRecipients
                          andBccRecipients:(NSArray *)bccRecipients
                                  addTheme:(NSString *)theme
                                   addBody:(NSString *)body
                         addAttachmentFile:(NSArray *)paths
                               addDelegate:(UIViewController *)delegate;

@end
