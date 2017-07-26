//
//  NSMutableAttributedString+Category.h
//  UIKit
//
//  Created by lkx on 16/4/15.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Category)

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置字体颜色
 *
 *  @param src   设置字体颜色子字符串
 *  @param color 颜色 - NSForegroundColorAttributeName
 */
- (void)setColorWithString:(NSString *)src color:(UIColor *)color;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置段落样式
 *
 *  @param src   设置段落样式的子字符串
 *  @param style 段落样式 - NSParagraphStyleAttributeName
 */
- (void)setParagraphStyle:(NSString *)src paragraphStyle:(NSParagraphStyle *)style;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置背景颜色
 *
 *  @param src      设置字体子字符串
 *  @param fontSize 字体大小 - NSFontAttributeName
 */
- (void)setFontSizeWithString:(NSString *)src fontSize:(CGFloat)fontSize;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置字体
 *
 *  @param src  设置字体的子字符串
 *  @param font 字体对象 - NSFontAttributeName
 */
- (void)setFontWithString:(NSString *)src font:(UIFont *)font;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置背景颜色
 *
 *  @param src     设置背景颜色的子字符串
 *  @param bgColor 背景颜色 - NSBackgroundColorAttributeName
 */
- (void)setBackgroundColorWithString:(NSString *)src backgroundColor:(UIColor *)bgColor;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置NSLigatureAttributeName(连字)
 *
 *  @param src      设置NSLigatureAttributeName的子字符串
 *  @param ligature ligature(0/1) - NSLigatureAttributeName
 */
- (void)setLigatureWithString:(NSString *)src ligature:(NSInteger)ligature;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置NSKernAttributeName(间距)
 *
 *  @param src   设置NSKernAttributeName的子字符串
 *  @param kern  kern - NSKernAttributeName
 */
- (void)setKernWithString:(NSString *)src kern:(float)kern;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置删除线风格和颜色
 *
 *  @param src   设置删除线风格的子字符串
 *  @param style 删除线风格 - NSStrikethroughStyleAttributeName
 *  @param color 删除线颜色 - NSStrikethroughColorAttributeName
 */
- (void)setStrikethroughStyleWithString:(NSString *)src strikethroughStyle:(NSUnderlineStyle)style color:(UIColor *)color;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置删除线颜色
 *
 *  @param src   设置删除线颜色的子字符串
 *  @param color 删除线颜色
 */
- (void)setStrikethroughColorWithString:(NSString *)src strikethroughColor:(UIColor *)color;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置下划线
 *
 *  @param src   设置下划线的子字符串
 *  @param style 下划线风格 - NSUnderlineStyleAttributeName
 *  @param color 下划线颜色 - NSUnderlineColorAttributeName
 */
- (void)setUnderLineStyleWithString:(NSString *)src underLineStyle:(NSUnderlineStyle)style color:(UIColor *)color;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置下划线颜色
 *
 *  @param src   设置下划线颜色的子字符串
 *  @param color 下划线颜色 - NSUnderlineColorAttributeName
 */
- (void)setUnderlineColorWithString:(NSString *)src underlineColor:(UIColor *)color;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置点中时的颜色
 *
 *  @param src   设置点中时的颜色的子字符串
 *  @param color 点中时的颜色 - NSStrokeColorAttributeName
 */
- (void)setStrokeColorWithString:(NSString *)src strokeColor:(UIColor *)color;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置点中时宽度
 *
 *  @param src         设置NSStrokeWidthAttributeName的子字符串
 *  @param strokeWidth strokeWidth - NSStrokeWidthAttributeName
 */
- (void)setStrokeWidthWithString:(NSString *)src strokeWidth:(CGFloat)strokeWidth;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置阴影
 *
 *  @param src    设置阴影的子字符串
 *  @param shadow shadow - NSShadowAttributeName
 */
- (void)setShadowWithString:(NSString *)src shadow:(NSShadow *)shadow;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置效应属性
 *
 *  @param src    设置效应属性的子字符串
 *  @param effect effect - NSTextEffectAttributeName
 */
- (void)setTextEffectWithString:(NSString *)src textEffect:(NSString *)effect;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置附件
 *
 *  @param src        设置效应属性的子字符串
 *  @param attachment attachment - NSAttachmentAttributeName
 */
- (void)setAttachmentWithString:(NSString *)src attachment:(NSTextAttachment *)attachment;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置链接属性
 *
 *  @param src  设置链接属性的子字符串
 *  @param link link(NSUrl or NSString) - NSLinkAttributeName
 */
- (void)setLinkWithString:(NSString *)src link:(id)link;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置线偏移
 *
 *  @param src    设置线偏移的子字符串
 *  @param offset offset - NSBaselineOffsetAttributeName
 */
- (void)setBaselineOffsetWithString:(NSString *)src baselineOffset:(CGFloat)offset;

/**
  *  @author 刘克邪
  *
  *  @brief  为NSMutableAttributedString设置倾斜度
  *
  *  @param src         设置倾斜度的子字符串
  *  @param obliqueness 倾斜度 - NSObliquenessAttributeName
  */
- (void)setObliquenessWithString:(NSString *)src obliqueness:(CGFloat)obliqueness;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置膨胀
 *
 *  @param src       设置膨胀的子字符串
 *  @param expansion 膨胀系数 - NSExpansionAttributeName
 */
- (void)setExpansionWithString:(NSString *)src expansion:(CGFloat)expansion;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString写作方向
 *
 *  @param src       设置写作方向的子字符串
 *  @param direction 写作方向(值查看NSWritingDirectionAttributeName的说明)
 */
- (void)setWritingDirectionWithString:(NSString *)src writingDirection:(NSInteger)direction;

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString垂直字体形式
 *
 *  @param src       设置垂直字体形式的子字符串
 *  @param glyphForm 垂直字体形式值(0,1) - NSVerticalGlyphFormAttributeName
 */
- (void)setVeriticalGlyphFormWithString:(NSString *)src verticalGlyphForm:(NSInteger)glyphForm;

@end
