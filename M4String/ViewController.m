//
//  ViewController.m
//  M2String
//
//  Created by Chen,Meisong on 2018/8/9.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableAttributedString+M4Linespace.h"
#import "NSMutableAttributedString+M4Tag.h"
#import "NSAttributedString+M2Size.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelAHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBHeightConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat linespace = 20;
    CGFloat maxWidth = 200;
    UIFont *font = [UIFont systemFontOfSize:20];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine;
    
    
    // M4Linespace
    NSLog(@"【chenms】M4Linespace----------  %s", __func__);
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
    NSString *moreLineText = @"中p中p中p中p中p中p中p中p中p中p中p";
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
    
    // M4Tag
    NSLog(@"【chenms】M4Tag----------  %s", __func__);
    self.labelA.attributedText = [moreLineAttrText mutableCopy];
//    NSLog(@"【chenms】self.labelA.attributedText:%@  %s", self.labelA.attributedText, __func__);
    CGFloat noHeight = [self.labelA.attributedText m2_heightWithMaxWidth:maxWidth
                                                            maxLineCount:0];
    NSLog(@"【chenms】noHeight:%.2f  %s", noHeight, __func__);
    self.labelAHeightConstraint.constant = noHeight;
    [self.view layoutIfNeeded];
    NSInteger noCount = [self.labelA.attributedText m4_lineCountWithMaxWidth:maxWidth
                                                                maxLineCount:0];
    NSLog(@"【chenms】noCount:%ld  %s", noCount, __func__);
    
    
    //
    NSString *tagText = moreLineText;
    NSMutableAttributedString *tagAttrText =
    [NSMutableAttributedString m7_custom_attributedStringWithString:tagText
                                                  tag:@"专题"
                                            yModifier:2];
    NSMutableParagraphStyle *tagPara = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    tagPara.lineSpacing = linespace;
    NSRange tagRange = NSMakeRange(0, [tagAttrText.string length]);
    [tagAttrText addAttribute:NSParagraphStyleAttributeName value:tagPara range:tagRange];
    [tagAttrText addAttribute:NSFontAttributeName value:font range:tagRange];
    self.labelB.attributedText = [tagAttrText mutableCopy];
//    NSLog(@"【chenms】self.labelB.attributedText:%@  %s", self.labelB.attributedText, __func__);
    CGFloat tagHeight = [self.labelB.attributedText m2_heightWithMaxWidth:maxWidth
                                                             maxLineCount:0];
    NSLog(@"【chenms】tagHeight:%.2f  %s", tagHeight, __func__);
    self.labelBHeightConstraint.constant = tagHeight;
    [self.view layoutIfNeeded];
    NSInteger tagCount = [self.labelB.attributedText m4_lineCountWithMaxWidth:maxWidth
                                                                maxLineCount:0];
    NSLog(@"【chenms】tagCount:%ld  %s", tagCount, __func__);
}

@end
