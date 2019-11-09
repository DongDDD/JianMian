//
//  JMPersonHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonHeaderTableViewCell.h"
#import "DimensMacros.h"


NSString *const JMPersonHeaderTableViewCellIdentifier = @"JMPersonHeaderTableViewCellIdentifier";

@interface JMPersonHeaderTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *suTitleLab;

@end


@implementation JMPersonHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMVitaDetailModel *)model{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.nameLab.text = model.user_nickname;
    if ([model.real_sex isEqualToString:@"1"]) {
        self.sexImg.image = [UIImage imageNamed:@"boy"];
    }else{
        self.sexImg.image = [UIImage imageNamed:@"girl"];
    }
    //工作经验
    NSString *workYear;
    if ([model.work_year isEqualToString:@"-1年"] || [model.work_year isEqualToString:@"低于1年"]) {
        workYear = @"应届生";
    }else{
        
        workYear = model.work_year;
    }
    //年龄

    //学历
    NSString *eduStr = [JMDataTransform getEducationStrWithEducation:model.vita_education];
    //城市
    NSString *cityName;
    if (model.city_city_name.length > 0) {
        cityName = model.city_city_name;
        
    }else{
        cityName = @"不限";
    }
    
    
    self.suTitleLab.text = [NSString stringWithFormat:@"%@ |  %@  | %@",workYear,eduStr,cityName];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
