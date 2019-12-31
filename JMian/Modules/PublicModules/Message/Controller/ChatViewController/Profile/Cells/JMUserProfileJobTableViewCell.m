//
//  JMUserProfileJobTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserProfileJobTableViewCell.h"
#import "JMDataTransform.h"
NSString *const JMUserProfileJobTableViewCellIdentifier = @"JMUserProfileJobTableViewCellIdentifier";
@interface JMUserProfileJobTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLab2;

@end

@implementation JMUserProfileJobTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//B
-(void)setJobData:(JMWorkModel *)jobData{
    self.titleLab.text = jobData.work_name;
    self.subTitleLab.text = [NSString stringWithFormat:@"工作经验:%@-%@年",jobData.work_experience_min,jobData.work_experience_max];
    NSString *education = [JMDataTransform getEducationStrWithEducationNum:jobData.education];
    self.subTitleLab2.text = [NSString stringWithFormat:@"学历：%@",education];
    
}

-(void)setTaskListData:(JMTaskListCellData *)taskListData{
    self.titleLab.text = taskListData.task_title;
    self.subTitleLab.text  = [NSString stringWithFormat:@"工作地点: %@",taskListData.cityName];
    self.subTitleLab2.text  = [NSString stringWithFormat:@"单价:  %@ 元 ",taskListData.payment_money];

    
}


//C
-(void)setVitaCModel:(JMVitaDetailModel *)vitaCModel{
    self.titleLab.text = vitaCModel.work_name;
    NSString *salary = [JMDataTransform getSalaryStrWithMin:vitaCModel.salary_min max:vitaCModel.salary_max];
    self.subTitleLab.text = [NSString stringWithFormat:@"期望要求: %@",salary];
    NSString *city;
    if (vitaCModel.city_city_name) {
        city = [NSString stringWithFormat:@"期望城市: %@",vitaCModel.city_city_name];
    }else{
        city = @"期望城市: %@ 不限";
    }
    
    self.subTitleLab2.text = city;
}

-(void)setAbilityCellData:(JMAbilityCellData *)abilityCellData{
    self.titleLab.text = abilityCellData.type_name;
    self.subTitleLab.text  = [NSString stringWithFormat:@"期望行业: %@",abilityCellData.type_name];
    self.subTitleLab2.text  = [NSString stringWithFormat:@"期望城市:  %@ ",abilityCellData.city_cityName];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
