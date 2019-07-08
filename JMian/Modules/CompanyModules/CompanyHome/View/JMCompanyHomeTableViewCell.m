//
//  JMCompanyHomeTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyHomeTableViewCell.h"
#import "DimensMacros.h"


@interface JMCompanyHomeTableViewCell ()

@property(nonatomic,strong)JMCompanyHomeModel *myModel;
@property (weak, nonatomic) IBOutlet UIImageView *playImgView;

@end


@implementation JMCompanyHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}


-(void)setModel:(JMCompanyHomeModel *)model{
    _myModel = model;
    self.jobNameLab.text = model.userNickname;
     [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
  
    NSString *salaryStr = [self getSalaryStrWithMin:model.salary_min max:model.salary_max];
    self.jobDetailLab.text = model.workName;
    self.salaryLab.text = salaryStr;
    self.educationLab.text = [self getEducationStrWithEducation:model.vitaEducation];
    self.subDecription.text = model.vita_description;
    if (model.video_file_path == nil || ![model.video_status isEqualToString:@"2"]) {
        [self.playBtn setHidden:YES];
        [self.playImgView setHidden:YES];
    }else{
        [self.playBtn setHidden:NO];
        [self.playImgView setHidden:NO];
        
    }
    NSString *expStr1 = [self getExpWithWork_start_date:model.vitaWork_start_date];
    NSString *expStr2;
    if (![expStr1 isEqualToString:@"0"]) {
        expStr2 = [NSString stringWithFormat:@"%@年",expStr1];
        
    }else{
        expStr2 = @"应届生";
    }
    self.experinenceLab.text = expStr2;

    
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


- (IBAction)playAction:(UIButton *)sender {
 
    if (_delegate && [_delegate respondsToSelector:@selector(playAction_cell:model:)]) {
        
        [_delegate playAction_cell:self model:_myModel];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
