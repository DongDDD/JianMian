//
//  JMComDetailHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMComDetailHeaderTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMComDetailHeaderTableViewCellIdentifier = @"JMComDetailHeaderTableViewCellIdentifier";
@interface JMComDetailHeaderTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation JMComDetailHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMCompanyInfoModel *)model{
     [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:model.logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.companyName.text = model.company_name;
    self.subTitle.text = [NSString stringWithFormat:@"%@ | %@ | %@",model.industry_name,model.financing,model.employee];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
