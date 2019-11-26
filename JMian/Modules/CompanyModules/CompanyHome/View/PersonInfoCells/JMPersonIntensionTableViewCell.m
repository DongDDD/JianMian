//
//  JMPersonIntensionTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonIntensionTableViewCell.h"
#import "JMDataTransform.h"
NSString *const JMPersonIntensionTableViewCellIdentifier = @"JMPersonIntensionTableViewCellIdentifier";
@interface JMPersonIntensionTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *workNameLab;
@property (weak, nonatomic) IBOutlet UILabel *workStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *workTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;

@end

@implementation JMPersonIntensionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMVitaDetailModel *)model{
    //期望职位
    self.workNameLab.text = model.work_name;
    //求职状态
    self.workStatusLab.text = model.vita_status;
    //参加工作时间
    self.workTimeLab.text = model.vita_work_start_date;
    //薪资
    self.salaryLab.text = [JMDataTransform getSalaryStrWithMin:model.salary_min max:model.salary_max];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
