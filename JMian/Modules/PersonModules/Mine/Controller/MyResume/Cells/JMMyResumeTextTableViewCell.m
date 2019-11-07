//
//  JMMyResumeTextTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/4/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeTextTableViewCell.h"

NSString *const JMMyResumeTextTableViewCellIdentifier = @"JMMyResumeTextTableViewCellIdentifier";


@interface JMMyResumeTextTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation JMMyResumeTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVitadescription:(NSString *)description {
    self.descriptionLabel.text = description;
}
@end
