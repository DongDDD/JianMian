//
//  JMUserProfileHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserProfileHeaderTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMUserProfileHeaderTableViewCellIdentifier = @"JMUserProfileHeaderTableViewCellIdentifier";
@interface JMUserProfileHeaderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation JMUserProfileHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(JMUserInfoModel *)model viewType:(JMUserProfileHeaderCellType)viewType{
    if (viewType == JMUserProfileHeaderCellTypeB) {
        self.titleLab.text = model.nickname;
        [self.titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        self.subTitleLab.text = [NSString stringWithFormat:@"%@", model.company_real_company_name];
        [self.subTitleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
         
    }else{
        self.titleLab.text = model.nickname;
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        [self.subTitleLab setHidden:YES];

    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
