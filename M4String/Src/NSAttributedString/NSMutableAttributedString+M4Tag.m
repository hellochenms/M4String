//
//  NSMutableAttributedString+M4Tag.m
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "NSMutableAttributedString+M4Tag.h"

@implementation NSMutableAttributedString (M4Tag)
- (void)m4_insertTag:(NSString *)tag
           tagHeight:(CGFloat)tagHeight
             tagFont:(UIFont *)tagFont
  tagBackgroundColor:(UIColor *)tagBackgroundColor
       tagTitleColor:(UIColor *)tagTitleColor
           yModifier:(CGFloat)yModifier
            xPadding:(CGFloat)xPadding {
    // Draw
    NSDictionary *attributes = @{NSFontAttributeName:tagFont,
                                 NSForegroundColorAttributeName:tagTitleColor
                                 };
    CGRect bounds = [tag boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                   attributes:attributes
                                      context:nil];
    //
    CGFloat cornerRadiusDouble = tagHeight;
    CGFloat tagWidth = ceil(bounds.size.width) + cornerRadiusDouble;
    CGFloat width = tagWidth + xPadding;
    
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
    
    // Attachment
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, -yModifier, width, tagHeight);
    
    // Insert
    [self insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
}

- (void)m4_sn_insertTag:(NSString *)tag
              yModifier:(CGFloat)yModifier {
    [self m4_insertTag:tag
             tagHeight:20
               tagFont:[UIFont systemFontOfSize:12]
    tagBackgroundColor:[UIColor blueColor]
         tagTitleColor:[UIColor whiteColor]
             yModifier:4
              xPadding:10];
}
@end
