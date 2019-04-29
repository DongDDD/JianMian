//
//  JMMyResumeWorkExperienceTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeWorkExperienceTableViewCell.h"

NSString *const JMMyResumeWorkExperienceTableViewCellIdentifier = @"JMMyResumeWorkExperienceTableViewCellIdentifier";

@interface JMMyResumeWorkExperienceTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;

@end

@implementation JMMyResumeWorkExperienceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWorkExperienceModel:(JMExperiencesModel *)model {
    self.jobLabel.text = model.work_name;
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date];
    self.companyLabel.text = model.company_name;
    self.descriptionLabel.text = model.experiences_description;
}

@end
