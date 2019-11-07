//
//  JMMyResumeIconTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeIconTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DimensMacros.h"

NSString *const JMMyResumeIconTableViewCellIdentifier = @"JMMyResumeIconTableViewCellIdentifier";

@interface JMMyResumeIconTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLab;

@end

@implementation JMMyResumeIconTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setUserInfo:(JMUserInfoModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.userNameLabel.text = model.nickname;
    if ([model.card_status isEqualToString:Card_PassIdentify]) {
        self.subLab.text = @"基本信息查看";
    }
    
}
@end
