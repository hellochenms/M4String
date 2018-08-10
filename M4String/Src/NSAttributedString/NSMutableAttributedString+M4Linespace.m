//
//  NSMutableAttributedString+M4Linespace.m
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "NSMutableAttributedString+M4Linespace.h"

static NSString * const kOneLineText = @"中p"; // 应该是什么都行

@implementation NSMutableAttributedString (M4Linespace)
- (void)m4_setLinespace:(CGFloat)UIMarkLinespace
               maxWidth:(CGFloat)maxWidth
           maxLineCount:(NSInteger)maxLineCount
           outputHeight:(CGFloat *)outputHeight
outputIsMoreThanMaxLineCount:(BOOL *)outputIsMoreThanMaxLineCount {
    // [Guard] 检查输入
    if (UIMarkLinespace <= 0) {
        NSLog(@"【m4】UIMarkLinespace<=0无操作  %s", __func__);
        return;
    }
    if (maxWidth <= 0) {
        NSLog(@"【m4】maxWidth<=0无操作  %s", __func__);
        return;
    }
    if (maxLineCount < 0) {
        maxLineCount = 0;
    }
    
    // [Process]修正行间距
    UIFont *font = [self attribute:NSFontAttributeName
                           atIndex:0
                    effectiveRange:nil];
    if (!font) {
        NSLog(@"【m4】本对象的NSFontAttributeName属性不能为空  %s", __func__);
        return;
    }
    CGFloat linespace = [font m4l_lineSpacingWithUIMarkLineSpaing:UIMarkLinespace];
    NSMutableParagraphStyle *para = [[self attribute:NSParagraphStyleAttributeName
                                             atIndex:0
                                      effectiveRange:nil] mutableCopy];
    if (!para) {
        para = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    }
    para.lineSpacing = linespace;
    [self addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, [self.string length])];
    
    // [Check]检查是否单行
    //// 计算单行行高
    NSDictionary *oneLineAttributes = @{NSFontAttributeName:font};
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine;
    CGFloat oneHeight = [kOneLineText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                   options:options
                                                attributes:oneLineAttributes
                                                   context:nil].size.height;
    //// 计算最大高度（单行行高 * n + 行间距 * (n - 1)）
    CGFloat maxHeight = 0;
    if (maxLineCount > 0) {
        maxHeight = oneHeight * maxLineCount + para.lineSpacing * (maxLineCount - 1);
    } else {
        maxHeight = MAXFLOAT;
    }
    
    //// 计算行高
    CGFloat height = [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                        options:options
                                        context:nil].size.height;
    
    // [Output]需要的话计算是否字符串全展开行数多于限制行数
    if (outputIsMoreThanMaxLineCount) {
        if (maxLineCount > 0) {
            CGFloat fullHeight = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                    options:options
                                                    context:nil].size.height;
            *outputIsMoreThanMaxLineCount = ((NSInteger)fullHeight > (NSInteger)height);
        } else {
            *outputIsMoreThanMaxLineCount = NO;
        }
    }
    
    //// 检查是否是单行
    BOOL isOneLine = ((NSInteger)height == (NSInteger)(oneHeight + para.lineSpacing));//用不用转型？
    if (isOneLine) {
        // [Process]单行则去除行间距
        CGFloat lineSpacing = para.lineSpacing;
        para.lineSpacing = 0;
        [self addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, [self.string length])];
        // 并修正行高
        height -= lineSpacing;
    }
    
    // [Output]需要的话输出高度
    if (outputHeight) {
        *outputHeight = ceil(height);
    }
}

@end

@implementation UIFont (M4Linespace)
- (double)m4l_lineSpacingWithUIMarkLineSpaing:(double)UIMarkLineSpaing {
    double lineSpacing = UIMarkLineSpaing - (self.lineHeight - self.pointSize);
    
    return (lineSpacing > 0 ? lineSpacing : 0);
}

@end
