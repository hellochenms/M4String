//
//  NSMutableAttributedString+M4Tag.h
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (M4Tag)
+ (NSMutableAttributedString *)m4_attributedStringWithString:(NSString *)string
                                                         tag:(NSString *)tag
                                            tagHeight:(CGFloat)tagHeight
                                              tagFont:(UIFont *)tagFont
                                   tagBackgroundColor:(UIColor *)tagBackgroundColor
                                        tagTitleColor:(UIColor *)tagTitleColor
                                          tailPadding:(CGFloat)tailPadding
                                            yModifier:(CGFloat)yModifier;//tag会和文字底对齐，要手动修正到中央对齐

// 项目中共通的可修改下使用
+ (NSMutableAttributedString *)m7_custom_attributedStringWithString:(NSString *)string
                                                                 tag:(NSString *)tag
                                         yModifier:(CGFloat)yModifier;
@end
