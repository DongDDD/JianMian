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



@implementation JMChatDetailInfoTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMyConModel:(JMMessageListModel *)myConModel
{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    //判断senderid是不是自己
    if (model.user_id == myConModel.sender_user_id) {
        
        self.name.text = myConModel.recipient_nickname;
    }else{
        self.name.text = myConModel.sender_nickname;
    }
    self.education.text = [self getEducationStrWithEducation:myConModel.work_education];
    self.salary.text = [self getSalaryStrWithMin:_myConModel.work_salary_min max:myConModel.work_salary_max];
    self.myDescription.text = myConModel.work_description;
    self.workName.text = myConModel.work_work_name;
    self.salary.text = [self getSalaryStrWithMin:myConModel.work_salary_min max:myConModel.work_salary_max];
    
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
