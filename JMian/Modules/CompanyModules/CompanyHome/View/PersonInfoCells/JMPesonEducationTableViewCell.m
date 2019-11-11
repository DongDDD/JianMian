//
//  JMPesonEducationTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPesonEducationTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMPesonEducationTableViewCellIdentifier = @"JMPesonEducationTableViewCellIdentifier";

@implementation JMPesonEducationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMEducationModel *)model{
    self.titleLab.text = model.school_school_name;
    NSString *eduStr = [JMDataTransform getEducationStrWithEducationNum:model.education];

    self.subTitleLab.text = [NSString stringWithFormat:@"%@/%@",eduStr,model.major];
    self.subTitleLab2.text = [NSString stringWithFormat:@"%@ ~ %@",model.s_date,model.e_date];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
