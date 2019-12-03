//
//  JMVideoJoblistTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoJoblistTableViewCell.h"
#import "JMDataTransform.h"
NSString *const JMVideoJoblistTableViewCellIdentifier = @"JMVideoJoblistTableViewCellIdentifier";

@interface JMVideoJoblistTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property (weak, nonatomic) IBOutlet UILabel *workDescLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end
@implementation JMVideoJoblistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.layer.shadowColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.18].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(0,0);
    _bgView.layer.shadowOpacity = 1;
    _bgView.layer.shadowRadius = 5;
    _bgView.layer.cornerRadius = 9;
}

-(void)setModel:(JMWorkModel *)model{
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
    if (model.city_name == nil) {
        cityStr = @"不限";
    }else{
        cityStr = [NSString stringWithFormat:@"%@",model.city_name];
    }
    
    self.subTitleLab.text = [NSString stringWithFormat:@"%@ | %@  | %@ ",experienceStr,educationStr,cityStr];
    self.salaryLab.text =   [NSString stringWithFormat:@" %@ ",salary];
    self.workDescLab.text = model.workDescription;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
