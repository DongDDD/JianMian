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

    NSString *expStr1 = [self getExpWithWork_start_date:model.vita_work_start_date];
      NSString *expStr2;
      if (![expStr1 isEqualToString:@"0"]) {
          expStr2 = [NSString stringWithFormat:@"%@年",expStr1];
          
      }else{
          expStr2 = @"应届生";
      }
    self.experiencesLab.text = expStr2;
    self.educationLab.text = [self getEducationStrWithEducation:model.vita_education];
//    self.cityLab.text
    self.workNameLab.text = model.work_name;
    self.workStatusLab.text = model.vita_status;
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

-(NSString *)getExpWithWork_start_date:(NSString *)work_start_date{
    //创建两个日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [dateFormatter dateFromString:work_start_date];
    NSDate *endDate = [NSDate date];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitYear;//只比较天数差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    //打印
    NSLog(@"%@",delta);
    //获取其中的"年"
    NSLog(@"----年：%ld",delta.year);
    NSString *expYear = [NSString stringWithFormat:@"%ld",(long)delta.year];
    return expYear;
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
-(NSString *)getWorkStatusStrWithStatusNum:(NSString *)statusNum{
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
