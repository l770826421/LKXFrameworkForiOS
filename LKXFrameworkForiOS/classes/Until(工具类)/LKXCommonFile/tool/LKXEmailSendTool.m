//
//  LKXEmailSendTool.m
//  LKXFrameworkForiOS
//
//  Created by Developer on 15/5/22.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "LKXEmailSendTool.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "NSString+category.h"

@implementation LKXEmailSendTool

/**
 *  @author 刘克邪
 *
 *  @brief  判断是否能启动邮件
 *
 */
+ (BOOL)canSendEmail {
    if (![MFMailComposeViewController canSendMail]) {
        LKXMLog(@"不能启动邮件");
        return NO;
    }
    return YES;
}

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
                              addBody:(NSString *)body
{
    if (![self canSendEmail]) {
        return;
    }
    
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    
    //添加收件人
    [mailUrl appendFormat:@"mailto:%@", [recipients componentsJoinedByString:@","]];
    
    //添加抄送
    [mailUrl appendFormat:@"?cc=%@", [ccRecipients  componentsJoinedByString:@","]];
    
    //添加密送
    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    
    //添加主题
    [mailUrl appendFormat:@"&subject=@%@", theme];
    
    //添加邮件内容
    [mailUrl appendFormat:@"&body=<b>%@</b>", body];
    // NSString *eamil = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *eamil = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eamil]];

}

/**
 *  用MFMailComposeViewController发送邮件,MFMailComposeViewController放在所在的UIViewController
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
                               addDelegate:(UIViewController *)delegate
{
    if (![self canSendEmail]) {
        return;
    }
    
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = (id<MFMailComposeViewControllerDelegate>)delegate;
    
    //设置主题
    [mailPicker setSubject:theme];
    //添加收件人
    [mailPicker setToRecipients:recipients];
    //添加抄送
    [mailPicker setCcRecipients:ccRecipients];
    
    //添加密送
    [mailPicker setBccRecipients:bccRecipients];
    
    for (NSString *path in paths)
    {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSString *name = [[path componentsSeparatedByString:@"/"] lastObject];
        [path mimeType:^(NSString *mimeType) {
            [mailPicker addAttachmentData:data mimeType:mimeType fileName:name];
        }];
    }
    
    NSString *emailBody = [NSString stringWithFormat:@"<font color='red'>%@</font>", body];
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [delegate presentViewController:mailPicker animated:YES completion:^{
        
    }];
}



@end
