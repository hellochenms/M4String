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
- (void)m4_insertTag:(NSString *)tag
           tagHeight:(CGFloat)tagHeight
             tagFont:(UIFont *)tagFont
  tagBackgroundColor:(UIColor *)tagBackgroundColor
       tagTitleColor:(UIColor *)tagTitleColor
           yModifier:(CGFloat)yModifier
            xPadding:(CGFloat)xPadding;
- (void)m4_sn_insertTag:(NSString *)tag
              yModifier:(CGFloat)yModifier;
@end
