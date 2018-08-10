//
//  NSMutableAttributedString+M4Tag.m
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "NSMutableAttributedString+M4Tag.h"

@implementation NSMutableAttributedString (M4Tag)
+ (NSMutableAttributedString *)m4_attributedStringWithString:(NSString *)string
                                            tag:(NSString *)tag
                                            tagHeight:(CGFloat)tagHeight
                                              tagFont:(UIFont *)tagFont
                                   tagBackgroundColor:(UIColor *)tagBackgroundColor
                                        tagTitleColor:(UIColor *)tagTitleColor
                                          tailPadding:(CGFloat)tailPadding
                                            yModifier:(CGFloat)yModifier {
    // [Guard]
    if (!string || [string length] == 0) {
        NSLog(@"【m4】string为空无操作  %s", __func__);
        return nil;
    }
    if (!tag || [tag length] == 0) {
        NSLog(@"【m4】tag为空无操作  %s", __func__);
        return nil;
    }
    if (tagHeight <= 0) {
        NSLog(@"【m4】tagHeight<=0无操作  %s", __func__);
        return nil;
    }
    if (!tagFont) {
        NSLog(@"【m4】tagFont为nil无操作  %s", __func__);
        return nil;
    }
    if (!tagBackgroundColor) {
        NSLog(@"【m4】tagBackgroundColor为nil无操作  %s", __func__);
        return nil;
    }
    if (!tagTitleColor) {
        NSLog(@"【m4】tagTitleColor为nil无操作  %s", __func__);
        return nil;
    }
    
    // 绘制图片
    NSDictionary *attributes = @{NSFontAttributeName:tagFont,
                                 NSForegroundColorAttributeName:tagTitleColor
                                 };
    CGRect bounds = [tag boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                   attributes:attributes
                                      context:nil];
    CGFloat cornerRadiusDouble = tagHeight;
    CGFloat tagWidth = ceil(bounds.size.width) + cornerRadiusDouble;
    CGFloat width = tagWidth + tailPadding;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, tagHeight), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, tagWidth, tagHeight)
                                                    cornerRadius:tagHeight / 2];
    CGContextAddPath(context, path.CGPath);
    CGContextSetFillColorWithColor(context, tagBackgroundColor.CGColor);
    CGContextFillPath(context);
    
    CGRect frame = bounds;
    frame.origin.x = (tagWidth - bounds.size.width) / 2;
    frame.origin.y = (tagHeight - bounds.size.height) / 2;
    [tag drawInRect:frame withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 将图片添加为Attachment
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, -yModifier, width, tagHeight);
    
    // 创建AttributedString
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:string];
    [attrText insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
    
    return attrText;
}

+ (NSMutableAttributedString *)m7_custom_attributedStringWithString:(NSString *)string
                                                                tag:(NSString *)tag
                                                          yModifier:(CGFloat)yModifier {
    return [self m4_attributedStringWithString:string
                                           tag:tag
             tagHeight:20
               tagFont:[UIFont systemFontOfSize:12]
    tagBackgroundColor:[UIColor blueColor]
         tagTitleColor:[UIColor whiteColor]
           tailPadding:10
             yModifier:yModifier];
}

@end
