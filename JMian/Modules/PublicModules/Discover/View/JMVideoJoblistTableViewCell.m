//
//  JMVideoJoblistTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoJoblistTableViewCell.h"
#import "JMDataTransform.h"
@interface JMVideoJoblistTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;


@end
@implementation JMVideoJoblistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMHomeWorkModel *)model{
//    _myModel = model;
    //    [self.myCopyBtn setHidden:YES];
    self.titleLab.text = model.work_name;
    NSString *salary = [JMDataTransform getSalaryStrWithMin:model.salary_min max:model.salary_max];
    NSString *experienceStr;
    if ([model.work_experience_max isEqualToString:@"0"]) {
        experienceStr = @"经验不限";
        
    }else{
        experienceStr = [NSString stringWithFormat:@"%@~%@年",model.work_experience_min,model.work_experience_max];
        
    }
    NSString *educationStr = [JMDataTransform getEducationStrWithEducationNum:model.education];
    NSString *cityStr;
    if (model.cityId == nil) {
        cityStr = @"不限";
    }else{
        cityStr = [NSString stringWithFormat:@"%@",model.cityName];
    }
    
    self.subTitleLab.text = [NSString stringWithFormat:@"%@ / %@ / %@ %@",experienceStr,educationStr,cityStr,salary];
    self.salaryLab.text = salary;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
