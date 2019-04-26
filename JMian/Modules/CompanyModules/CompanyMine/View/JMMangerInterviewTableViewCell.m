//
//  JMMangerInterviewTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMangerInterviewTableViewCell.h"

@implementation JMMangerInterviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(JMInterVIewModel *)model{
    self.nameLab.text = model.interviewer_work_name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
