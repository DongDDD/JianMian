//
//  JMPostJobHomeTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostJobHomeTableViewCell.h"

@implementation JMPostJobHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMHomeWorkModel *)model{
    
    self.workNameLab.text = model.work_name;
    NSString *experienceStr = [NSString stringWithFormat:@"%@~%@年",model.work_experience_min,model.work_experience_max];
    NSString *educationStr = [self getEducationStrWithEducation:model.education];
    NSString *cityStr;
    if (model.cityId == nil) {
        cityStr = @"不限";
    }else{
        cityStr = model.cityName;
    }
    
    self.detailLab.text = [NSString stringWithFormat:@"%@ / %@ / %@",experienceStr,educationStr,cityStr];
   
    NSString *salary = [self getSalaryStrWithMin:model.salary_min max:model.salary_max];
    
    self.salaryLab.text = salary;

}

-(void)setPartTimeJobModel:(JMAbilityCellData *)partTimeJobModel{
    self.workNameLab.text = partTimeJobModel.type_name;
    
    self.salaryLab.text = partTimeJobModel.city_cityName;
    
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMIndustryModel *model in partTimeJobModel.industry) {
        [industryNameArray addObject:model.name];
    }
    NSString *industry = [industryNameArray componentsJoinedByString:@"/"];
    self.detailLab.text = industry;
 
//    self.detailLab.text = [NSString stringWithFormat:@"%@ / %@ / %@",experienceStr,educationStr,cityStr];
//
//    NSString *salary = [self getSalaryStrWithMin:model.salary_min max:model.salary_max];
//
//    self.salaryLab.text = salary;
    
}


-(void)setTaskListCellData:(JMTaskListCellData *)taskListCellData{
    self.workNameLab.text = taskListCellData.task_title;
    self.salaryLab.text = [NSString stringWithFormat:@"%@ 元",taskListCellData.payment_money];
    if (taskListCellData.cityID == nil) {
        self.detailLab.text = @"不限";
    }else{
        self.detailLab.text = taskListCellData.cityName;
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
