//
//  NSMutableAttributedString+M2Highlight.h
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (M2Highlight)
- (void)m2_highlightKeyword:(NSString *)keyword
                      color:(UIColor *)color;
@end
