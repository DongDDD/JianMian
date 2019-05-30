//
//  JMMyResumeHeaderTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeHeaderTableViewCell.h"

NSString *const JMMyResumeHeaderTableViewCellIdentifier = @"JMMyResumeHeaderTableViewCellIdentifier";
NSString *const JMMyResumeHeader2TableViewCellIdentifier = @"JMMyResumeHeader2TableViewCellIdentifier";
NSString *const JMMyResumeHeader3TableViewCellIdentifier = @"JMMyResumeHeader3TableViewCellIdentifier";
NSString *const JMMyResumeHeader4TableViewCellIdentifier = @"JMMyResumeHeader4TableViewCellIdentifier";

@interface JMMyResumeHeaderTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *headerArrowBtn;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;

@end

@implementation JMMyResumeHeaderTableViewCell

- (void)cellConfigWithIdentifier:(NSString *)identifier imageViewName:(NSString *)imageViewName title:(NSString *)title {
    self.headerImageView.image = [UIImage imageNamed:imageViewName];
    self.headerLabel.text = title;
    if (identifier != JMMyResumeHeader3TableViewCellIdentifier) {
        self.headerArrowBtn.hidden = YES;
        if ([title isEqualToString:@"教育经历"]) {
            self.addLabel.hidden = NO;
        }else {
            self.addLabel.hidden = YES;
        }

    }else {
        self.headerArrowBtn.hidden = NO;
        self.addLabel.hidden = YES;
    }
    
}

 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
