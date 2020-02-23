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
    

    // 将webView添加到界面
    // Initialization code
}

-(void)setDescStr:(NSString *)descStr{
    
//    NSString *myStr = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;}</style></head>",self.contentView.frame.size.width-20];
//    NSString *str = [NSString stringWithFormat:@"%@%@",myStr,descStr];
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.left.mas_equalTo(self.contentView).offset(10);

        make.bottom.mas_equalTo(self);
        
        make.top.mas_equalTo(self);
    }];
    //    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[descStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //    [self.lab setAttributedText:attrStr];
    
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //HTML5的高度
//    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
//    //HTML5的宽度
//    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
//   //宽高比
//    float i = [htmlWidth floatValue]/[htmlHeight floatValue];
//    CGFloat h = [htmlHeight floatValue];
//    //webview控件的最终高度
//     float height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
////    float height = self.contentView.frame.size.width/i;
////    if (_delegate && [_delegate respondsToSelector:@selector(getGoodsH:)])
////    {
////        [_delegate getGoodsH:h];
////    }
//    CGRect frame = webView.frame;
//
//    CGSize size = [webView sizeThatFits:CGSizeZero];
//
//    frame.size = size;
//
//    webView.frame = frame;
//}

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

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
//        _webView.scrollView.scrollEnabled = NO;
//        _webView.scrollView.bounces = NO;
//        _webView.scrollView.showsVerticalScrollIndicator = NO;
//        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    }
    return _webView;
    
}

@end
