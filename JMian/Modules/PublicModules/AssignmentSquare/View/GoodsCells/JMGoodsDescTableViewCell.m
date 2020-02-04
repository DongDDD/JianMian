//
//  JMGoodsDescTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsDescTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMGoodsDescTableViewCellIdentifier = @"JMGoodsDescTableViewCellIdentifier";

@implementation JMGoodsDescTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDescStr:(NSString *)descStr{
    
    NSString *myStr = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;}</style></head>",self.contentView.frame.size.width-20];
    NSString *str = [NSString stringWithFormat:@"%@%@",myStr,descStr];
    self.webView.delegate = self;
      [self.webView loadHTMLString:str baseURL:nil];

//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[descStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    [self.lab setAttributedText:attrStr];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //HTML5的高度
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    //HTML5的宽度
    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
   //宽高比
    float i = [htmlWidth floatValue]/[htmlHeight floatValue];
    
    //webview控件的最终高度
    float height = self.contentView.frame.size.width/i;
    if (_delegate && [_delegate respondsToSelector:@selector(getGoodsH:)])
    {
        [_delegate getGoodsH:height];
    }
    
}

- (CGFloat)boundingRectWithSize:(CGSize)size WithStr:(NSString*)string andFont:(UIFont *)font andLinespace:(CGFloat)space
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:space];
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    CGSize retSize = [string boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
