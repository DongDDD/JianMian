//
//  JMCDetailProduceTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailProduceTableViewCell.h"
NSString *const JMCDetailProduceTableViewCellIdentifier = @"JMCDetailProduceTableViewCellIdentifier";

@interface JMCDetailProduceTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *produceName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JMCDetailProduceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMCDetailModel *)data{
    self.produceName.text = data.goods_goods_title;
    self.price.text = [NSString stringWithFormat:@"%@ 元",data.goods_goods_price];
    [self.textView setText:data.goods_description];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.textView.text attributes:attributes];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
