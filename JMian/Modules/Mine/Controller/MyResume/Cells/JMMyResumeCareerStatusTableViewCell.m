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
@property (weak, nonatomic) IBOutlet UIView *workStutasView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end
@implementation JMMyResumeCareerStatusTableViewCell


- (void)setWorkStatus:(NSString *)workStatus {
    for (id sub in self.workStutasView.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            int status = [workStatus intValue];
            UIButton *btn = (UIButton *)sub;
            if (status == btn.tag) {
                [btn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateNormal];
            }else {
                [btn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
            }
        }
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
