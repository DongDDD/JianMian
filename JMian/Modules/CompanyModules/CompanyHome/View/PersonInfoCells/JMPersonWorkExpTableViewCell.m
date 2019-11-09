//
//  JMPersonWorkExpTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonWorkExpTableViewCell.h"
NSString *const JMPersonWorkExpTableViewCellIdentifier = @"JMPersonWorkExpTableViewCellIdentifier";
@interface JMPersonWorkExpTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UILabel *workPositionLab;
@property (weak, nonatomic) IBOutlet UILabel *workTimeLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
@implementation JMPersonWorkExpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMExperiencesModel *)model{
    self.companyNameLab.text = model.company_name;
    self.workPositionLab.text = model.work_name;
//    self.workTimeLab = model.
    [self.textView setText:model.experiences_description];
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
