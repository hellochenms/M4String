//
//  ViewController.m
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableAttributedString+M4Linespace.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat linespace = 10;
    CGFloat maxWidth = 200;
    UIFont *font = [UIFont systemFontOfSize:20];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine;
    
    // 单行
    NSString *oneLineText = @"中p";
    NSMutableAttributedString *oneLineAttrText = [[NSMutableAttributedString alloc] initWithString:oneLineText];
    NSMutableParagraphStyle *para = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    para.lineSpacing = linespace;
    NSRange oneRange = NSMakeRange(0, [oneLineAttrText.string length]);
    [oneLineAttrText addAttribute:NSParagraphStyleAttributeName value:para range:oneRange];
    [oneLineAttrText addAttribute:NSFontAttributeName value:font range:oneRange];
    CGRect oneLineRect = [oneLineAttrText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                       options:options
                                                       context:nil];
    NSLog(@"【chenms】oneLineRect.size.height:%.2f  %s", ceil(oneLineRect.size.height), __func__);
    CGFloat oneLineModifyHeight = 0;
    [oneLineAttrText m4_setLinespace:linespace
                            maxWidth:maxWidth
                        maxLineCount:0
                        outputHeight:&oneLineModifyHeight
        outputIsMoreThanMaxLineCount:nil];
    NSLog(@"【chenms】oneLineModifyHeight:%.2f  %s", oneLineModifyHeight, __func__);
    
    // 多行
    NSString *moreLineText = @"中p中p中p中p中p中p中p中p";
    NSMutableAttributedString *moreLineAttrText = [[NSMutableAttributedString alloc] initWithString:moreLineText];
    NSMutableParagraphStyle *morePara = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    morePara.lineSpacing = linespace;
    NSRange moreRange = NSMakeRange(0, [moreLineAttrText.string length]);
    [moreLineAttrText addAttribute:NSParagraphStyleAttributeName value:morePara range:moreRange];
    [moreLineAttrText addAttribute:NSFontAttributeName value:font range:moreRange];
    CGRect moreLineRect = [moreLineAttrText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                       options:options
                                                       context:nil];
    NSLog(@"【chenms】moreLineRect.size.height:%.2f  %s", ceil(moreLineRect.size.height), __func__);
    CGFloat moreLineModifyHeight = 0;
    [moreLineAttrText m4_setLinespace:linespace
                            maxWidth:maxWidth
                        maxLineCount:0
                        outputHeight:&moreLineModifyHeight
        outputIsMoreThanMaxLineCount:nil];
    NSLog(@"【chenms】moreLineModifyHeight:%.2f  %s", moreLineModifyHeight, __func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
