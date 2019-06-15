//
//  JMMangerInterviewTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMangerInterviewTableViewCell.h"
#import "DimensMacros.h"
#import "JMInterViewModel.h"

@interface JMMangerInterviewTableViewCell ()
@property(nonatomic,strong)JMInterViewModel *myModel;
@property (weak, nonatomic) IBOutlet UIImageView *passImg;

@end

@implementation JMMangerInterviewTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] )
    {
        
    }
    
    return self;
}

#pragma mark - //C端面试列表状态


-(void)init_C_TypeViewWith:(JMInterViewModel *)model
{
    self.nameLab.text = model.work_work_name;
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:model.company_logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    //    self.IconImage.image = GETImageFromURL(model.candidate_avatar);
    self.salaryLab.text = [self getSalaryStrWithMin:model.work_salary_min max:model.work_salary_max];
    
    //公司名称
    self.detailLab.text = model.company_company_name;
    
    if ([model.status isEqualToString:Interview_WaitAgree]) {//B端邀请C端面试，等待C同意
        self.headerTitleLab.textColor = MASTER_COLOR;
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        [self.leftBtn setTitle:@"接受邀约" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"残忍拒绝" forState:UIControlStateNormal];
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        
    }else if ([model.status isEqualToString:@"3"]){//C端接受邀约了
        if ([self isTimeToInterview_time:model.time]){//面试时间到了 或者迟到
            self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
            self.headerTitleLab.textColor = MASTER_COLOR;
//            [self.leftBtn setTitle:@"面试结束" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"进入房间" forState:UIControlStateNormal];
            [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
            [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            [self.leftBtn setHidden:YES];
            [self.rightBtn setHidden:NO];
            self.rightBtn.layer.borderWidth = 0.5;
            self.rightBtn.layer.masksToBounds = YES;
            self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        }else{
            
            self.headerTitleLab.textColor = MASTER_COLOR;
            self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
            [self.rightBtn setTitle:@"等待面试" forState:UIControlStateNormal];
            [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
            [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            [self.leftBtn setHidden:YES];
            [self.rightBtn setHidden:NO];
            self.rightBtn.layer.borderWidth = 0.5;
            self.rightBtn.layer.masksToBounds = YES;
            self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
            
        }
        
        
        
        
    }else if ([model.status isEqualToString:Interview_Refuse]){//你 C端已拒绝
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = TEXT_GRAY_COLOR;
        [self.rightBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
    }else if ([model.status isEqualToString:@"4"]){
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        [self.rightBtn setTitle:@"面试反馈" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:MASTER_COLOR];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    }else if ([model.status isEqualToString:@"5"]){
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        [self.rightBtn setTitle:@"已反馈" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
        [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.rightBtn.layer.borderWidth = 0.5;
        self.rightBtn.layer.masksToBounds = YES;
        self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        
    }
    
}

//比较两个日期的大小
- (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end
{
    NSComparisonResult result = [stary compare: end];
    if (result==NSOrderedSame)
    {
        //相等
        return  NO;
    }
    return NO;
}

//字符串转时间
- (NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}
#pragma mark - //B端面试列表状态
//B端面试列表状态。录用状态：0:未确定 1:不合适 2:已录用
-(void)init_B_TypeViewWith:(JMInterViewModel *)model
{
//    NSLog(@"时间：------%@",[self getTimeinterval_time:model.time]);
    self.nameLab.text = model.candidate_nickname;
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:model.candidate_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    //    self.IconImage.image = GETImageFromURL(model.candidate_avatar);
    self.salaryLab.text = [self getSalaryStrWithMin:model.work_salary_min max:model.work_salary_max];
    
    //工作经验
    NSArray  *array = [model.vita_work_start_date componentsSeparatedByString:@"-"];
    NSInteger nowYear =  [array[0] integerValue];
    NSInteger expInt = 2019 - nowYear;
    NSString *expStr = [NSString stringWithFormat:@"%ld",(long)expInt];
    
    //学历
    NSString *eduStr = [self getEducationStrWithEducation:model.vita_work_education];
    
    //职位名称
    NSString *workName = model.work_work_name;
    //-----status------状态判断,布局下方按钮UI
    self.detailLab.text = [NSString stringWithFormat:@"%@年 / %@ / %@",expStr,eduStr,workName];
    
    if ([model.status isEqualToString:Interview_WaitAgree]) {//你邀请了C端面试，正在等待C端同意
        self.headerTitleLab.textColor = MASTER_COLOR;
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@（等待同意）",model.time];
        self.rightBtn.layer.borderWidth = 0;
        [self.rightBtn setTitle:@"取消面试" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:TEXT_GRAYmin_COLOR];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.passImg setHidden:YES];
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        [self.deleteImg setHidden:YES];



    }else if ([model.status isEqualToString:@"3"] ){//C端接受邀约了
        
        
        if ([self isTimeToInterview_time:model.time]){//面试时间到了 或者迟到
            self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
            self.headerTitleLab.textColor = MASTER_COLOR;
            self.rightBtn.layer.borderWidth = 0.5;

            [self.leftBtn setTitle:@"面试结束" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"进入房间" forState:UIControlStateNormal];
            [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
            [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            [self.leftBtn setHidden:YES];
            [self.rightBtn setHidden:NO];
            [self.deleteImg setHidden:YES];
            [self.passImg setHidden:YES];

            self.rightBtn.layer.borderWidth = 0.5;
            self.rightBtn.layer.masksToBounds = YES;
            self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        }else{
            //面试时间还没到
            self.headerTitleLab.textColor = MASTER_COLOR;
            self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@（已同意）",model.time];
            self.rightBtn.layer.borderWidth = 0.5;

            [self.rightBtn setTitle:@"等待面试" forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.rightBtn setBackgroundColor:MASTER_COLOR];
            [self.leftBtn setHidden:YES];
            [self.rightBtn setHidden:NO];
            [self.deleteImg setHidden:YES];
            [self.passImg setHidden:YES];


        }
        
    }else if ([model.status isEqualToString:@"2"]){//C端已拒绝
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:YES];
        [self.deleteImg setHidden:NO];
        [self.deleteImg setImage:[UIImage imageNamed:@"countermand"]];
        [self.passImg setHidden:YES];
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = TEXT_GRAY_COLOR;
    }
//录用状态：点击已面试返回的状态 录用状态：0:未确定 1:不合适 2:已录用
    else if ([model.hire isEqualToString:@"0"] && [model.status isEqualToString:@"4"]){//0:未确定
        
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = MASTER_COLOR;
        [self.leftBtn setTitle:@"确认录用" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"不合适" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]];
        self.rightBtn.layer.borderWidth = 0;
        [self.leftBtn setBackgroundColor:MASTER_COLOR];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        [self.deleteImg setHidden:YES];
        [self.passImg setHidden:YES];

        
    }else if ([model.hire isEqualToString:@"2"]){//2:已录用 
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = MASTER_COLOR;
        [self.rightBtn setTitle:@"已录用" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
        [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.rightBtn.layer.borderWidth = 0.5;
        self.rightBtn.layer.masksToBounds = YES;
        self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        [self.deleteImg setHidden:YES];
        [self.passImg setHidden:NO];
        
    }else if ([model.hire isEqualToString:@"1"]){//1:不通过
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = MASTER_COLOR;
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:YES];
        [self.deleteImg setHidden:NO];
        [self.passImg setHidden:YES];
        
        self.deleteImg.image = [UIImage imageNamed:@"no_pass"];
        
    }
    
    
}



//-(NSString*)getCurrentTimes{
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//
//    //现在时间,你可以输出来看下是什么格式
//
//    NSDate *datenow = [NSDate date];
//
//    //----------将nsdate按formatter格式转成nsstring
//
//    NSString *currentTimeString = [formatter stringFromDate:datenow];
//
//    NSLog(@"currentTimeString =  %@",currentTimeString);
//
//    return currentTimeString;
//
//}
-(NSString *)getCountDownStringWithEndTime:(NSString *)endTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//设置时区
    NSInteger interval = [zone secondsFromGMTForDate: now];
    NSDate *localDate = [now  dateByAddingTimeInterval: interval];
    endTime = [NSString stringWithFormat:@"%@ 23:59", endTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    NSInteger endInterval = [zone secondsFromGMTForDate: endDate];
    NSDate *end = [endDate dateByAddingTimeInterval: endInterval];
    NSUInteger voteCountTime = ([end timeIntervalSinceDate:localDate]) / 3600 / 24;
    
    NSString *timeStr = [NSString stringWithFormat:@"%lu", (unsigned long)voteCountTime];
    
    return timeStr;
}


- (IBAction)leftBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellLeftBtnActionWith_model:)]) {
        
        [self.delegate cellLeftBtnActionWith_model:_myModel];
    }
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellRightBtnAction_model:isInterviewTime:)]) {
        [self.delegate cellRightBtnAction_model:_myModel isInterviewTime:[self isTimeToInterview_time:_myModel.time]];
    }
}


-(void)setModel:(JMInterViewModel *)model{
    _myModel = model;
    
    NSLog(@"%@",[self getCountDownStringWithEndTime:model.time]);
    
    //本地获取账户类型企业还是个人，再决定Cell的布局
    JMUserInfoModel *userinfoModel = [JMUserInfoManager getUserInfo];
    
    if ([userinfoModel.type isEqualToString:C_Type_USER]) {
        [self init_C_TypeViewWith:model];
        
    }else if ([userinfoModel.type isEqualToString:B_Type_UESR]){
        [self init_B_TypeViewWith:model];
        
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


//-(BOOL)currentIsInterviewTime_myInterviewTime:(NSString *)myInterviewTime{
//
//    NSDate *interviewTimeDate = [self nsstringConversionNSDate:myInterviewTime];
//    NSDate *currentTimeDate =  [self nsstringConversionNSDate:[self getCurrentTimes]];
//    BOOL currentIsInterviewTime = [self compareDate:interviewTimeDate withDate:currentTimeDate];
//    return currentIsInterviewTime;
//}

//-(NSString*)getCurrentTimes{
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//
//    //现在时间,你可以输出来看下是什么格式
//
//    NSDate *datenow = [NSDate date];
//
//    //----------将nsdate按formatter格式转成nsstring
//
//    NSString *currentTimeString = [formatter stringFromDate:datenow];
//
//    NSLog(@"currentTimeString =  %@",currentTimeString);
//
//    return currentTimeString;
//
//}

//-(NSString *)getNowTimeTimestamp{
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//
//    //设置时区,这个对于时间的处理有时很重要
//
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//
//    [formatter setTimeZone:timeZone];
//
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//
//    NSString *time = [NSString stringWithFormat:@"%@",datenow];
////    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//    NSLog(@"-----%@",time);
//    return time;
//
//}

-(BOOL)isTimeToInterview_time:(NSString *)time{

    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *creat = [formatter dateFromString:(time)];// 将传入的字符串转化成时间
//    NSTimeInterval delta = [localeDate timeIntervalSinceDate:creat]; // 计算出相差多少秒

    
    NSTimeInterval value=[creat timeIntervalSinceDate:localeDate];

    NSLog(@"时间差 ： 秒单位=%f",value);
    if (value < 5*60) {
        
        
        
        return YES;
        
    }
    
    
    return NO;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
