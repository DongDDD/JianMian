//
//  JMMyResumeCareerStatusTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeCareerStatusTableViewCell.h"

NSString *const JMMyResumeCareerStatusTableViewCellIdentifier = @"JMMyResumeCareerStatusTableViewCellIdentifier";
NSString *const JMMyResumeCareerStatus2TableViewCellIdentifier = @"JMMyResumeCareerStatus2TableViewCellIdentifier";

@interface JMMyResumeCareerStatusTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *workTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *workStutasView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end
@implementation JMMyResumeCareerStatusTableViewCell

- (void)cellConfigWithIdentifier:(NSString *)identifier {
    if (identifier == JMMyResumeCareerStatusTableViewCellIdentifier) {
        self.workTimeLabel.hidden = YES;
        self.workStutasView.hidden = NO;
        self.cellTitle.text = @"求职状态";
    }else {
        self.workStutasView.hidden = YES;
        self.workTimeLabel.hidden = NO;
        self.cellTitle.text = @"参加工作时间";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
