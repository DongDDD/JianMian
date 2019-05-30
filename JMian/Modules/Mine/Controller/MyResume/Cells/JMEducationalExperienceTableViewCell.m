//
//  JMEducationalExperienceTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/4/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMEducationalExperienceTableViewCell.h"

NSString *const JMEducationalExperienceTableViewCellIdentifier = @"JMEducationalExperienceTableViewCellIdentifier";

@interface JMEducationalExperienceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;

@end

@implementation JMEducationalExperienceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEducationExperienceModel:(JMLearningModel *)model {
    self.schoolNameLabel.text = model.school_name;
}
@end
