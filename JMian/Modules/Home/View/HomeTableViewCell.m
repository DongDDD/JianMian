//
//  HomeTableViewCell.m
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "DimensMacros.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    // Initialization code
}

-(void)setModel:(JMHomeWorkModel *)model{
    _model = model;
    self.workNameLab.text = model.work_name;
   
    NSString *salaryStr = [self getSalaryStrWithMin:model.salary_min max:model.salary_max];
    self.salaryLab.text = salaryStr;
    NSString *experienceStr;
    if ([model.work_experience_min isEqualToString:@"0"]) {        
        experienceStr = @"不限";
    }else{
        experienceStr = [NSString stringWithFormat:@"%@~%@年",model.work_experience_min,model.work_experience_max];
    }
    self.workExperienceLab.text = experienceStr;
    
    NSString *cityStr = [NSString stringWithFormat:@"%@",model.cityName];
    self.cityLab.text = cityStr;
    
    NSString *eduStr = [self getEducationStrWithEducation:model.education];
    self.educationLab.text = eduStr;
    
    NSString *company = [NSString stringWithFormat:@"%@",model.companyName];
    self.companyNameLab.text = company;
    
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:model.companyLogo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    if (model.videoFile_path == nil) {
        [self.playBtn setHidden:YES];
    }else{
        [self.playBtn setHidden:NO];
    }
}

- (IBAction)playAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playAction_cell:model:)]) {
        
        [_delegate playAction_cell:self model:_model];
    }
    
}



//工资数据转化，除以1000，转化成k
-(NSString *)getSalaryStrWithMin:(id)min max:(id)max{
    NSInteger myint = [min integerValue];
    NSInteger intMin = myint/1000;
    
    NSInteger myint2 = [max integerValue];
    NSInteger intMax = myint2/1000;
   
    NSString *salaryStr;
    salaryStr = [NSString stringWithFormat:@"%dk~%dk",  (int)intMin, (int)intMax];
    
    return salaryStr;
}

//学历数据转化
-(NSString *)getEducationStrWithEducation:(NSString *)education{
    NSInteger myInt = [education integerValue];
    
    switch (myInt) {
        case 0:
            return @"不限";
            break;
        case 1:
            return @"初中";
            break;
        case 2:
            return @"中专";
            break;
        case 3:
            return @"高中";
            break;
        case 4:
            return @"大专";
            break;
        case 5:
            return @"本科";
            break;
        case 6:
            return @"硕士";
            break;
        case 7:
            return @"博士";
            break;
            
        default:
            break;
    }
    return @"不限";
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
