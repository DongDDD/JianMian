//
//  JMPostJobHomeTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostJobHomeTableViewCell.h"
@interface JMPostJobHomeTableViewCell ()

@property (nonatomic, strong)JMHomeWorkModel *myModel;
@property (nonatomic, strong)JMTaskListCellData *myTaskListCellData;
@property (weak, nonatomic) IBOutlet UIButton *myCopyBtn;

@end
@implementation JMPostJobHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//全职职位
-(void)setModel:(JMHomeWorkModel *)model{
    _myModel = model;
    _viewType = JMPostJobHomeTableViewCellTypeWork;
//    [self.myCopyBtn setHidden:YES];
    self.workNameLab.text = model.work_name;
    NSString *salary = [self getSalaryStrWithMin:model.salary_min max:model.salary_max];
    NSString *experienceStr;
    if ([model.work_experience_max isEqualToString:@"0"]) {
        experienceStr = @"经验不限";
        
    }else{
        experienceStr = [NSString stringWithFormat:@"%@~%@年",model.work_experience_min,model.work_experience_max];
        
    }
    NSString *educationStr = [self getEducationStrWithEducation:model.education];
    NSString *cityStr;
    if (model.cityId == nil) {
        cityStr = @"不限";
    }else{
        cityStr = [NSString stringWithFormat:@"%@",model.cityName];
    }
    
    self.detailLab.text = [NSString stringWithFormat:@"%@ / %@ / %@ %@",experienceStr,educationStr,cityStr,salary];
   
    if ([model.status isEqualToString:@"0"]) {
        self.salaryLab.text = @"已下线";
        [self.salaryLab setHidden:NO];
    }else{
        [self.salaryLab setHidden:YES];
    }

}

//兼职简历
-(void)setPartTimeJobModel:(JMAbilityCellData *)partTimeJobModel{
    [self.myCopyBtn setHidden:YES];
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

//兼职任务管理
-(void)setTaskListCellData:(JMTaskListCellData *)taskListCellData{
    _viewType = JMPostJobHomeTableViewCellTypeTask;
    _myTaskListCellData = taskListCellData;
    self.workNameLab.text = taskListCellData.task_title;
    if (taskListCellData.cityID == nil) {
        self.detailLab.text = [NSString stringWithFormat:@"不限-%@/单",taskListCellData.payment_money];
    }else{
        self.detailLab.text =[NSString stringWithFormat:@"%@-%@/单",taskListCellData.cityName,taskListCellData.payment_money] ;
    }
    if ([taskListCellData.status isEqualToString:@"0"]) {
        self.salaryLab.text = @"已下线";
        [self.salaryLab setHidden:NO];
    }else{
        [self.salaryLab setHidden:YES];
    }
    
}

- (IBAction)copyAction:(id)sender {
    if (_viewType == JMPostJobHomeTableViewCellTypeWork) {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickCopyActionWithHomeWorkModel:)]) {
        
            [_delegate didClickCopyActionWithHomeWorkModel:_myModel];
        }
    }else if (_viewType == JMPostJobHomeTableViewCellTypeTask) {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickCopyActionWithTaskListCellData:)]) {
            [_delegate didClickCopyActionWithTaskListCellData:_myTaskListCellData];
        }
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
