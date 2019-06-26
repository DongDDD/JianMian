//
//  JMChatDetailInfoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChatDetailInfoTableViewCell.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "DimensMacros.h"
@interface JMChatDetailInfoTableViewCell ()

@property(nonatomic,strong)JMMessageListModel *myModel;

@end

@implementation JMChatDetailInfoTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:95/255.0 blue:133/255.0 alpha:0.1].CGColor;
        self.bgView.layer.shadowOffset = CGSizeMake(0,2);
        self.bgView.layer.shadowOpacity = 1;
        self.bgView.layer.shadowRadius = 5;
        self.bgView.layer.borderWidth = 0.5;
        self.bgView.layer.borderColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0].CGColor;
    }
    return self;
}
-(void)setMyConModel:(JMMessageListModel *)myConModel
{
    _myModel = myConModel;
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    //判断senderid是不是自己
    if (model.user_id == myConModel.sender_user_id) {
        
        self.name.text = myConModel.recipient_nickname;
    }else{
        self.name.text = myConModel.sender_nickname;
    }
    
    [self setValuesWithChatType:myConModel.type];
    
//    self.education.text = [self getEducationStrWithEducation:myConModel.work_education];
//    self.salary.text = [self getSalaryStrWithMin:_myConModel.work_salary_min max:myConModel.work_salary_max];
//    self.myDescription.text = myConModel.work_description;
//    self.lab3.text = myConModel.work_work_name;
//    self.salary.text = [self getSalaryStrWithMin:myConModel.work_salary_min max:myConModel.work_salary_max];
    
}

-(void)setValuesWithChatType:(NSString *)chatType{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([chatType isEqualToString:@"1"]) {//全职对话赋值
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            self.lab1.text = [self getEducationStrWithEducation:_myModel.work_education];
            self.salary.text = [self getSalaryStrWithMin:_myModel.work_salary_min max:_myModel.work_salary_max];
            self.myDescription.text = _myModel.work_description;
            self.lab3.text = _myModel.work_work_name;
            self.salary.text = [self getSalaryStrWithMin:_myModel.work_salary_min max:_myModel.work_salary_max];
        }else{
            self.lab1.text = [self getEducationStrWithEducation:_myModel.work_education];
            self.salary.text = [self getSalaryStrWithMin:_myModel.work_salary_min max:_myModel.work_salary_max];
            self.myDescription.text = _myModel.work_description;
            self.lab3.text = _myModel.work_work_name;
            self.salary.text = [self getSalaryStrWithMin:_myModel.work_salary_min max:_myModel.work_salary_max];
            
        }
        
    }else if ([chatType isEqualToString:@"2"]){//兼职对话赋值
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            self.salary.text = _myModel.job_type_label_name;
            self.myDescription.text = _myModel.job_description;
            NSMutableArray *array = [NSMutableArray array];
            for (JMChatInfoIndustry *industryModel in _myModel.job_industry) {
                [array addObject:industryModel.name];
            }
            
//            self.lab1.text = array[0];
//            self.lab2.text = array[1];
//            self.lab3.text = array[2];
        }else{
            self.salary.text = _myModel.job_type_label_name;
            self.myDescription.text = _myModel.job_description;
            NSMutableArray *array = [NSMutableArray array];
            for (JMChatInfoIndustry *industryModel in _myModel.job_industry) {
                [array addObject:industryModel.name];
            }
            self.lab1.text = array[0];
            self.lab2.text = array[1];
            self.lab3.text = array[2];
        
        }
        
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
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self == [self initWithFrame:frame]) {
////          self.bgView.layer.shadowOffset = CGSizeMake(0, 5);
////
////          self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
////
////          self.bgView.layer.shadowOpacity = 1;//阴影透明度，默认0
////
////          self.bgView.layer.shadowRadius = 5;//阴影半径，默认3
////
////          self.bgView.layer.masksToBounds = NO;
////
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
