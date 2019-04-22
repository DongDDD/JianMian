//
//  JMMyResumeCareerObjectiveTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeCareerObjectiveTableViewCell.h"

NSString *const JMMyResumeCareerObjectiveTableViewCellIdentifier = @"JMMyResumeCareerObjectiveTableViewCellIdentifier";

@interface JMMyResumeCareerObjectiveTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation JMMyResumeCareerObjectiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCareerObjectiveWithLeftLabelText:(NSString *)text {
    self.leftLabel.text = text;
}

- (void)setCareerObjectiveWithRightLabelText:(NSString *)text {
    self.rightLabel.text = text;
}
@end
