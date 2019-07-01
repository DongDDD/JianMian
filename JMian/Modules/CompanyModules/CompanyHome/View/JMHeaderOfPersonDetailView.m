//
//  JMHeaderOfPersonDetailView.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHeaderOfPersonDetailView.h"
#import "DimensMacros.h"

@implementation JMHeaderOfPersonDetailView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"JMHeaderOfPersonDetailView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}

-(void)setModel:(JMVitaDetailModel *)model{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.realNameLab.text = model.user_nickname;
    
    if ([model.real_sex isEqualToString:@"1"]) {
        self.sexImageView.image = [UIImage imageNamed:@"boy"];
        
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"girl"];

    
    }
    //    self.sexImageView =
    //    self.experiencesLab.text
    self.educationLab.text = [self getEducationStrWithEducation:model.vita_education];
//    self.cityLab.text
    self.workNameLab.text = model.work_name;
    self.workStatusLab.text = [self getWorkStatusStrWithEducation:model.work_status];
    self.workStartDate.text = model.vita_work_start_date;
    self.salaryLab.text = [self getSalaryStrWithMin:model.salary_min max:model.salary_max];

}

-(void)setCompanyHomeModel:(JMCompanyHomeModel *)companyHomeModel
{
    
    if (companyHomeModel.video_file_path == nil) {
        self.labToheaderTop.constant = 21;
        [self.videoImg setHidden:YES];
        [self.playBtn setHidden:YES];
        
    }


}

- (IBAction)playAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playAction)]) {
        [_delegate playAction];
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

//数据转化
-(NSString *)getWorkStatusStrWithEducation:(NSString *)statusNum{
    NSInteger myInt = [statusNum integerValue];
    
    switch (myInt) {
        case 0:
            return @"未知";
            break;
        case 1:
            return @"应届生";
            break;
        case 2:
            return @"离职-随时到岗";
            break;
        case 3:
            return @"在职-月内到岗";
            break;
        case 4:
            return @"在职-考虑机会";
            break;
        case 5:
            return @"在职-暂不考虑";
            break;
            
        default:
            break;
    }
    return @"不限";
    
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

//-(UIImage *)getSexImageFromNum:(NSNumber *)sex{
//
//    if (sex == @0) {
//        return  [UIImage imageNamed:@""];
//    }else if (sex == @1){
//        return  [UIImage imageNamed:@"boy"];
//
//
//    }else if (sex == @2){
//        return  [UIImage imageNamed:@"girl"];
//
//
//    }
//
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
