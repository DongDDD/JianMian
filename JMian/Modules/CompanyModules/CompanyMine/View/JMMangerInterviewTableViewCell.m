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



//C端面试列表状态
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
        
    }else if ([model.status isEqualToString:Interview_WaitInterview]){//C端接受邀约了
        self.headerTitleLab.textColor = MASTER_COLOR;
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        [self.rightBtn setTitle:@"等待面试" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
        [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        
    }else if ([model.status isEqualToString:Interview_Delete]){//你 C端已拒绝
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = TEXT_GRAY_COLOR;
        [self.rightBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
    }else if ([model.status isEqualToString:Interview_AlreadyInterview]){//面试时间过了 或者 面试时间前5分钟的状态
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:YES];
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = MASTER_COLOR;
        [self.leftBtn setTitle:@"面试结束" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"进入房间" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
        [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        self.rightBtn.layer.borderWidth = 0.5;
        self.rightBtn.layer.masksToBounds = YES;
        self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        
    }else if ([model.status isEqualToString:Interview_Reflect]){
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:NO];
        [self.rightBtn setTitle:@"面试反馈" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:MASTER_COLOR];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    }
    
    
    
}


//B端面试列表状态
-(void)init_B_TypeViewWith:(JMInterViewModel *)model
{
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
    self.detailLab.text = [NSString stringWithFormat:@"%@年 / %@ / %@",expStr,eduStr,workName];
    
    if ([model.status isEqualToString:Interview_WaitAgree]) {//你邀请了C端面试，正在等待C端同意
        self.headerTitleLab.textColor = MASTER_COLOR;
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@（等待同意）",model.time];
        [self.leftBtn setTitle:@"修改时间" forState:UIControlStateNormal];
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:YES];

    }else if ([model.status isEqualToString:Interview_WaitInterview]){//C端接受邀约了
        self.headerTitleLab.textColor = MASTER_COLOR;
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@（已同意）",model.time];
        [self.leftBtn setTitle:@"修改时间" forState:UIControlStateNormal];
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:YES];

    }else if ([model.status isEqualToString:Interview_Delete]){//C端已拒绝
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:YES];
        [self.deleteImg setHidden:NO];
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = TEXT_GRAY_COLOR;
    }else if ([model.status isEqualToString:Interview_AlreadyInterview]){//面试时间过了 或者 面试时间前5分钟的状态
        [self.leftBtn setHidden:YES];
        [self.rightBtn setHidden:YES];
        self.headerTitleLab.text = [NSString stringWithFormat:@"面试邀请：%@",model.time];
        self.headerTitleLab.textColor = MASTER_COLOR;
        [self.leftBtn setTitle:@"面试结束" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"进入房间" forState:UIControlStateNormal];
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0]];
        [self.rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self.leftBtn setHidden:NO];
        [self.rightBtn setHidden:NO];
        self.rightBtn.layer.borderWidth = 0.5;
        self.rightBtn.layer.masksToBounds = YES;
        self.rightBtn.layer.borderColor = MASTER_COLOR.CGColor;
        
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
    
    NSString *timeStr = [NSString stringWithFormat:@"%d", voteCountTime];
    
    return timeStr;
}


- (IBAction)leftBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellLeftBtnActionWith_model:)]) {
        
        [self.delegate cellLeftBtnActionWith_model:_myModel];
    }
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellRightBtnAction_model:)]) {
        
        [self.delegate cellRightBtnAction_model:_myModel];
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





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
