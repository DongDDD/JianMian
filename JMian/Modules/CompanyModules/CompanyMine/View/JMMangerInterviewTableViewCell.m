//
//  JMMangerInterviewTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMangerInterviewTableViewCell.h"
#import "DimensMacros.h"

@implementation JMMangerInterviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)leftBtnAction:(UIButton *)sender {
    [self.delegate cellLeftBtnActionWith_row:_myRow];
}

- (IBAction)RightBtnAction:(UIButton *)sender {
    [self.delegate cellRightBtnAction_row:_myRow];
}


-(void)setModel:(JMInterVIewModel *)model{
    
    self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@（等待同意）",model.time];
    
    self.nameLab.text = model.candidate_nickname;
     [self.IconImage sd_setImageWithURL:[NSURL URLWithString:model.candidate_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//    self.IconImage.image = GETImageFromURL(model.candidate_avatar);
    self.salaryLab.text = [self getSalaryStrWithMin:model.work_salary_min max:model.work_salary_max];

    //工作经验
    NSArray  *array = [model.vita_work_start_date componentsSeparatedByString:@"-"];
    NSInteger nowYear =  [array[0] integerValue];
    NSInteger expInt = 2019 - nowYear;
    NSString *expStr = [NSString stringWithFormat:@"%ld",(long)expInt];
    
    //学历
    NSString *eduStr = [self getEducationStrWithEducation:model.vita_work_education];
    
    //职位名称
    NSString *workName = model.work_work_name;

    self.detailLab.text = [NSString stringWithFormat:@"%@年 / %@ / %@",expStr,eduStr,workName];
    
    
    
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
            return @"初中及以下";
            break;
        case 2:
            return @"中专/中技";
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
