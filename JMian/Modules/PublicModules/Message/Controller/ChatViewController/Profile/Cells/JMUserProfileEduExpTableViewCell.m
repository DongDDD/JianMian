//
//  JMUserProfileEduExpTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserProfileEduExpTableViewCell.h"
#import "JMDataTransform.h"
NSString *const JMUserProfileEduExpTableViewCellIdentifier = @"JMUserProfileEduExpTableViewCellIdentifier";

@implementation JMUserProfileEduExpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMVitaDetailModel *)model{
    self.schoolNameLab.text = model.diploma_school_name;
//    self.timeLab.text = [NSString stringWithFormat:@"%@- %@",model.s_date,model.e_date];
    self.majorLab.text = model.diploma_major;
    self.eduLab.text = [JMDataTransform getEducationStrWithEducationNum:model.diploma_education];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
