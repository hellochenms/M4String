//
//  NSAttributedString+M2Size.m
//  M4String
//
//  Created by Chen,Meisong on 2018/8/10.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "NSAttributedString+M2Size.h"

static NSString * const kOneLineText = @"中p"; // 应该是什么都行

@implementation NSAttributedString (M2Size)
- (CGFloat)m2_heightWithMaxWidth:(CGFloat)maxWidth
                    maxLineCount:(NSInteger)maxLineCount {
    CGSize size = [self m2_sizeWithMaxWidth:maxWidth
                               maxLineCount:maxLineCount];
    
    return ceil(size.height);
}

- (CGSize)m2_sizeWithMaxWidth:(CGFloat)maxWidth
                 maxLineCount:(NSInteger)maxLineCount {
    // [Guard]
    UIFont *font = [self attribute:NSFontAttributeName
                           atIndex:8
                    effectiveRange:nil];
    if (!font) {
        NSLog(@"【m2】本对象的NSFontAttributeName属性不能为空  %s", __func__);
        return CGSizeZero;
    }
    
    // 计算单行行高
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine;
    NSDictionary *oneLineAttributes = @{NSFontAttributeName:font};
    CGFloat oneHeight = [kOneLineText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                   options:options
                                                attributes:oneLineAttributes
                                                   context:nil].size.height;
    // 计算最大高度（单行行高 * n + 行间距 * (n - 1)）
    CGFloat linespace = 0;
    NSMutableParagraphStyle *para = [[self attribute:NSParagraphStyleAttributeName
                                             atIndex:0
                                      effectiveRange:nil] mutableCopy];
    if (para) {
        linespace = para.lineSpacing;
    }
    CGFloat maxHeight = 0;
    if (maxLineCount > 0) {
        maxHeight = oneHeight * maxLineCount + linespace * (maxLineCount - 1);
    } else {
        maxHeight = MAXFLOAT;
    }
    
    // 计算bound
    CGRect bound = [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                      options:options
                                      context:nil];
    
    return bound.size;
}

- (NSInteger)m4_lineCountWithMaxWidth:(CGFloat)maxWidth
                         maxLineCount:(NSInteger)maxLineCount {
    // [Guard]
    UIFont *font = [self attribute:NSFontAttributeName
                           atIndex:8
                    effectiveRange:nil];
    if (!font) {
        NSLog(@"【m2】本对象的NSFontAttributeName属性不能为空  %s", __func__);
        return 0;
    }
    // 计算单行行高
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine;
    NSDictionary *oneLineAttributes = @{NSFontAttributeName:font};
    CGFloat oneHeight = [kOneLineText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                   options:options
                                                attributes:oneLineAttributes
                                                   context:nil].size.height;
    // 计算全展开行高
    CGFloat linespace = 0;
    NSMutableParagraphStyle *para = [[self attribute:NSParagraphStyleAttributeName
                                             atIndex:0
                                      effectiveRange:nil] mutableCopy];
    if (para) {
        linespace = para.lineSpacing;
    }
    CGFloat height = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                      options:options
                                      context:nil].size.height;
    //// oneHeight * n + linespace * (n - 1) = height, n即count
    NSInteger count = (height + linespace) / (oneHeight + linespace);// 会不会有误差，比如2.999舍为2
    
    // 取MIN(全展开行高, 限制行高)
    if (maxLineCount > 0) {
        count = MIN(count, maxLineCount);
    }
    
    return count;
}

@end
