//
//  JMComDetailContentTableViewCell.m
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMComDetailContentTableViewCell.h"
NSString *const JMComDetailContentTableViewCellIdentifier = @"JMComDetailContentTableViewCellIdentifier";
@interface JMComDetailContentTableViewCell ()
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation JMComDetailContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMCompanyInfoModel *)model{
    [self.textView setText:model.comDescription];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
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
