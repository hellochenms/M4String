//
//  NSMutableAttributedString+M4Linespace.h
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (M4Linespace)
- (void)m4_setLinespace:(CGFloat)linespace
               maxWidth:(CGFloat)maxWidth
           maxLineCount:(NSInteger)maxLineCount
           outputHeight:(CGFloat *)outputHeight
outputIsMoreThanMaxLineCount:(BOOL *)outputIsMoreThanMaxLineCount;
@end

@interface UIFont (M4Linespace)
- (double)m4l_lineSpacingWithUIMarkLineSpaing:(double)UIMarkLineSpaing;
@end
