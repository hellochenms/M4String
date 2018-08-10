//
//  NSMutableAttributedString+M2Highlight.m
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "NSMutableAttributedString+M2Highlight.h"

@implementation NSMutableAttributedString (M2Highlight)
- (void)m2_highlightKeyword:(NSString *)keyword
                      color:(UIColor *)color {
    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([self.string length] == 0
        || !keyword
        || [keyword length] == 0
        || !color) {
        return;
    }
    
    //
    keyword = [self _m2_formatKeyword:keyword];
    
    NSRegularExpression *regex
    = [NSRegularExpression regularExpressionWithPattern:keyword
                                                options:NSRegularExpressionCaseInsensitive
                                                  error:nil];
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:self.string
                                                              options:0
                                                                range:NSMakeRange(0, self.string.length)];
    
    UIColor *keywordColor = color;
    
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [result range];
        [self addAttribute:NSForegroundColorAttributeName value:keywordColor range:range];
    }];
}

- (NSString *)_m2_formatKeyword:(NSString *)keyword {
    NSString *formatedKeyword = keyword;
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"?" withString:@"\\?"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"+" withString:@"\\+"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"." withString:@"\\."];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"*" withString:@"\\*"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"^" withString:@"\\^"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"|" withString:@"\\|"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"$" withString:@"\\$"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"(" withString:@"\\("];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@")" withString:@"\\)"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"[" withString:@"\\["];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"]" withString:@"\\]"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"{" withString:@"\\{"];
    formatedKeyword = [formatedKeyword stringByReplacingOccurrencesOfString:@"}" withString:@"\\}"];
    
    return formatedKeyword;
}
@end
