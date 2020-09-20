//
//  NSMutableAttributedString+LKXCategory.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/15.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "NSMutableAttributedString+LKXCategory.h"

@implementation NSMutableAttributedString (LKXCategory)

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置字体颜色
 *
 *  @param src   设置字体颜色子字符串
 *  @param color 颜色 - NSForegroundColorAttributeName
 */
- (void)lkx_setColorWithString:(NSString *)src color:(UIColor *)color {
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置段落样式
 *
 *  @param src   设置段落样式的子字符串
 *  @param style 段落样式 - NSParagraphStyleAttributeName
 */
- (void)lkx_setParagraphStyle:(NSString *)src paragraphStyle:(NSParagraphStyle *)style {
    
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSParagraphStyleAttributeName
                 value:style
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置背景颜色
 *
 *  @param src      设置字体子字符串
 *  @param fontSize 字体大小 - NSFontAttributeName
 */
- (void)lkx_setFontSizeWithString:(NSString *)src fontSize:(CGFloat)fontSize {
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    [self lkx_setFontWithString:src font:font];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置字体
 *
 *  @param src  设置字体的子字符串
 *  @param font 字体对象 - NSFontAttributeName
 */
- (void)lkx_setFontWithString:(NSString *)src font:(UIFont *)font {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSFontAttributeName
                 value:font
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置背景颜色
 *
 *  @param src     设置背景颜色的子字符串
 *  @param bgColor 背景颜色 - NSBackgroundColorAttributeName
 */
- (void)lkx_setBackgroundColorWithString:(NSString *)src backgroundColor:(UIColor *)bgColor {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSBackgroundColorAttributeName
                 value:bgColor
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置NSLigatureAttributeName(连字)
 *
 *  @param src      设置NSLigatureAttributeName的子字符串
 *  @param ligature ligature(0/1) - NSLigatureAttributeName
 */
- (void)lkx_setLigatureWithString:(NSString *)src ligature:(NSInteger)ligature {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSLigatureAttributeName
                 value:@(ligature)
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置NSKernAttributeName(核心?)
 *
 *  @param src   设置NSKernAttributeName的子字符串
 *  @param kern  kern - NSKernAttributeName
 */
- (void)lkx_setKernWithString:(NSString *)src kern:(float)kern {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSKernAttributeName
                 value:@(kern)
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置删除线风格和颜色
 *
 *  @param src   设置删除线风格的子字符串
 *  @param style 删除线风格 - NSStrikethroughStyleAttributeName
 *  @param color 删除线颜色 - NSStrikethroughColorAttributeName
 */
- (void)lkx_setStrikethroughStyleWithString:(NSString *)src strikethroughStyle:(NSUnderlineStyle)style color:(UIColor *)color {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSStrikethroughStyleAttributeName
                 value:@(style)
                 range:range];
    [self lkx_setStrikethroughColorWithString:src
                           strikethroughColor:color];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置删除线颜色
 *
 *  @param src   设置删除线颜色的子字符串
 *  @param color 删除线颜色
 */
- (void)lkx_setStrikethroughColorWithString:(NSString *)src strikethroughColor:(UIColor *)color {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSStrikethroughColorAttributeName
                 value:color
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置下划线
 *
 *  @param src   设置下划线的子字符串
 *  @param style 下划线风格 - NSUnderlineStyleAttributeName
 *  @param color 下划线颜色 - NSUnderlineColorAttributeName
 */
- (void)lkx_setUnderLineStyleWithString:(NSString *)src underLineStyle:(NSUnderlineStyle)style color:(UIColor *)color {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSUnderlineStyleAttributeName
                 value:@(style)
                 range:range];
    [self lkx_setUnderlineColorWithString:src
                           underlineColor:color];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置下划线颜色
 *
 *  @param src   设置下划线颜色的子字符串
 *  @param color 下划线颜色 - NSUnderlineColorAttributeName
 */
- (void)lkx_setUnderlineColorWithString:(NSString *)src underlineColor:(UIColor *)color {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSUnderlineColorAttributeName
                 value:color
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置点中时的颜色
 *
 *  @param src   设置点中时的颜色的子字符串
 *  @param color 点中时的颜色 - NSStrokeColorAttributeName
 */
- (void)lkx_setStrokeColorWithString:(NSString *)src strokeColor:(UIColor *)color {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSStrokeColorAttributeName
                 value:color
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置点中时宽度
 *
 *  @param src         设置NSStrokeWidthAttributeName的子字符串
 *  @param strokeWidth strokeWidth - NSStrokeWidthAttributeName
 */
- (void)lkx_setStrokeWidthWithString:(NSString *)src strokeWidth:(CGFloat)strokeWidth {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSStrokeWidthAttributeName
                 value:@(strokeWidth)
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置阴影
 *
 *  @param src    设置阴影的子字符串
 *  @param shadow shadow - NSShadowAttributeName
 */
- (void)lkx_setShadowWithString:(NSString *)src shadow:(NSShadow *)shadow {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSShadowAttributeName
                 value:shadow
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置效应属性
 *
 *  @param src    设置效应属性的子字符串
 *  @param effect effect - NSTextEffectAttributeName
 */
- (void)lkx_setTextEffectWithString:(NSString *)src textEffect:(NSString *)effect {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSTextEffectAttributeName
                 value:effect
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置附件
 *
 *  @param src        设置效应属性的子字符串
 *  @param attachment attachment - NSAttachmentAttributeName
 */
- (void)lkx_setAttachmentWithString:(NSString *)src attachment:(NSTextAttachment *)attachment {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSAttachmentAttributeName
                 value:attachment
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置链接属性
 *
 *  @param src  设置链接属性的子字符串
 *  @param link link(NSUrl or NSString) - NSLinkAttributeName
 */
- (void)lkx_setLinkWithString:(NSString *)src link:(id)link {
    
    NSParameterAssert([link isKindOfClass:[NSURL class]] || [link isKindOfClass:[NSString class]]);
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSLinkAttributeName
                 value:link
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置线偏移
 *
 *  @param src    设置线偏移的子字符串
 *  @param offset offset - NSBaselineOffsetAttributeName
 */
- (void)lkx_setBaselineOffsetWithString:(NSString *)src baselineOffset:(CGFloat)offset {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSBaselineOffsetAttributeName
                 value:@(offset)
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置倾斜度
 *
 *  @param src         设置倾斜度的子字符串
 *  @param obliqueness 倾斜度 - NSObliquenessAttributeName
 */
- (void)lkx_setObliquenessWithString:(NSString *)src obliqueness:(CGFloat)obliqueness {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSObliquenessAttributeName
                 value:@(obliqueness)
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString设置膨胀
 *
 *  @param src       设置膨胀的子字符串
 *  @param expansion 膨胀系数 - NSExpansionAttributeName
 */
- (void)lkx_setExpansionWithString:(NSString *)src expansion:(CGFloat)expansion {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSExpansionAttributeName
                 value:@(expansion)
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString写作方向
 *
 *  @param src       设置写作方向的子字符串
 *  @param direction 写作方向(值查看NSWritingDirectionAttributeName的说明)
 */
- (void)lkx_setWritingDirectionWithString:(NSString *)src writingDirection:(NSInteger)direction {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSWritingDirectionAttributeName
                 value:@(direction)
                 range:range];
}

/**
 *  @author 刘克邪
 *
 *  @brief  为NSMutableAttributedString垂直字体形式
 *
 *  @param src       设置垂直字体形式的子字符串
 *  @param glyphForm 垂直字体形式值(0,1) - NSVerticalGlyphFormAttributeName
 */
- (void)lkx_setVeriticalGlyphFormWithString:(NSString *)src verticalGlyphForm:(NSInteger)glyphForm {
    
    NSRange range = [self.string rangeOfString:src];
    [self addAttribute:NSVerticalGlyphFormAttributeName
                 value:@(glyphForm)
                 range:range];
}

@end
