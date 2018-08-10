//
//  NSAttributedString+M2Size.h
//  M4String
//
//  Created by Chen,Meisong on 2018/8/10.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (M2Size)
- (CGFloat)m2_heightWithMaxWidth:(CGFloat)maxWidth
                    maxLineCount:(NSInteger)maxLineCount;
- (CGSize)m2_sizeWithMaxWidth:(CGFloat)maxWidth
                 maxLineCount:(NSInteger)maxLineCount;
- (NSInteger)m4_lineCountWithMaxWidth:(CGFloat)maxWidth
                         maxLineCount:(NSInteger)maxLineCount;
@end
