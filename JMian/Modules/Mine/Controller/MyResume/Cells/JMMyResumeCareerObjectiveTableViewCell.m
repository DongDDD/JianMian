//
//  JMMyResumeCareerObjectiveTableViewCell.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeCareerObjectiveTableViewCell.h"

NSString *const JMMyResumeCareerObjectiveTableViewCellIdentifier = @"JMMyResumeCareerObjectiveTableViewCellIdentifier";

@interface JMMyResumeCareerObjectiveTableViewCell ()
//@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
//@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *workNameLab;

@end

@implementation JMMyResumeCareerObjectiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCareerObjectiveWithModel:(JMMyJobsModel *)model {
    self.workNameLab.text = model.work_name;
    NSString *city;
    if (model.city_city_name != nil) {
        city = model.city_city_name;
    }else{
        city = @"城市暂未选择";
    }
    NSString *salaryStr = [self getSalaryKtransformStrWithMin:model.salary_min max:model.salary_max];
    
    self.detailLab.text = [NSString stringWithFormat:@"%@ / %@",city,salaryStr];

}

//工资数据转化，除以1000，转化成k
-(NSString *)getSalaryKtransformStrWithMin:(id)min max:(id)max{
    NSInteger myint = [min integerValue];
    NSInteger intMin = myint/1000;
    
    NSInteger myint2 = [max integerValue];
    NSInteger intMax = myint2/1000;
    
    NSString *salaryStr;
    salaryStr = [NSString stringWithFormat:@"%dk~%dk",  (int)intMin, (int)intMax];
    
    return salaryStr;
}

//- (void)setCareerObjectiveWithRightLabelText:(NSString *)text {
//    self.rightLabel.text = text;
//}
@end
