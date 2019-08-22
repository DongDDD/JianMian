//
//  JMCompanyLikeTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyLikeTableViewCell.h"
#import "DimensMacros.h"
#import "Masonry.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"

@interface JMCompanyLikeTableViewCell ()

@property(nonatomic,strong)JMCTypeLikeModel *cLike_model;
@property(nonatomic,strong)JMBTypeLikeModel *bLike_model;
@property(nonatomic,strong)JMBPartTimeJobLikeModel *myBPartTimeJobLikeModel;
@property(nonatomic,strong)JMCPartTimeJobLikeModel *myCPartTimeJobLikeModel;
@property(nonatomic,copy)NSString *recipient;
@property(nonatomic,copy)NSString *foreign_key;


@end

@implementation JMCompanyLikeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] )
   {
       JMUserInfoModel *userinfoModel = [JMUserInfoManager getUserInfo];
       
       if ([userinfoModel.type isEqualToString:C_Type_USER]) {
           
           
       }else if ([userinfoModel.type isEqualToString:B_Type_UESR]){
           
           
       }
       
   }
    
    return self;
}

-(void)setBTypeLikeModel:(JMBTypeLikeModel *)BTypeLikeModel{
    _recipient = BTypeLikeModel.job_user_id;
    _foreign_key = BTypeLikeModel.foreign_key;
    _bLike_model = BTypeLikeModel;

    self.nameLab.text = BTypeLikeModel.job_user_nickname;
    self.contentLab.text = BTypeLikeModel.job_vita_description;
    self.salaryLab.text = [self getSalaryStrWithMin:BTypeLikeModel.job_salary_min max:BTypeLikeModel.job_salary_max];
    NSString *eduStr = [self getEducationStrWithEducation:BTypeLikeModel.job_vita_education];
    NSString *detailStr = [NSString stringWithFormat:@"%@/%@",eduStr,BTypeLikeModel.job_work_name];
    if (eduStr!=nil) {
        
        self.detailLab.text = detailStr;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:BTypeLikeModel.job_user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];

    
}

-(void)setCTypeLikeModel:(JMCTypeLikeModel *)CTypeLikeModel{
    _recipient = CTypeLikeModel.work_user_id;
    _foreign_key = CTypeLikeModel.foreign_key;
    _cLike_model = CTypeLikeModel;
    self.nameLab.text = CTypeLikeModel.work_company_company_name;
    self.contentLab.text = CTypeLikeModel.work_description;

    self.salaryLab.text = [self getSalaryStrWithMin:CTypeLikeModel.work_salary_min max:CTypeLikeModel.work_salary_max];
//    NSString *eduStr = [self getEducationStrWithEducation:CTypeLikeModel.ed];
//    NSString *detailStr = [NSString stringWithFormat:@"%@/%@",eduStr,CTypeLikeModel.job_work_name];
    
    self.detailLab.text = CTypeLikeModel.work_address;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:CTypeLikeModel.work_company_logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
}

-(void)setBPartTimeJobLikeModel:(JMBPartTimeJobLikeModel *)BPartTimeJobLikeModel{
    _recipient = BPartTimeJobLikeModel.ability_user_user_id;
    _foreign_key = BPartTimeJobLikeModel.foreign_key;
    _myBPartTimeJobLikeModel = BPartTimeJobLikeModel;
    self.nameLab.text = BPartTimeJobLikeModel.ability_user_nickname;
    self.salaryLab.text = @"";
    self.contentLab.text = BPartTimeJobLikeModel.ability_description;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:BPartTimeJobLikeModel.ability_user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    //职位标签
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMBLikeIndustryModel *IndustryData in BPartTimeJobLikeModel.ability_industry) {
        [industryNameArray addObject:IndustryData.name];
    }
    NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
    self.detailLab.text = industryStr;

 
}


-(void)setCPartTimeJobLikeModel:(JMCPartTimeJobLikeModel *)CPartTimeJobLikeModel{
    _recipient = CPartTimeJobLikeModel.task_user_user_id;
    _foreign_key = CPartTimeJobLikeModel.foreign_key;
    _myCPartTimeJobLikeModel = CPartTimeJobLikeModel;
    self.nameLab.text = CPartTimeJobLikeModel.company_company_name;
    if (CPartTimeJobLikeModel.task_payment_money) {
        self.salaryLab.text = [NSString stringWithFormat:@"%@%@",CPartTimeJobLikeModel.task_payment_money,CPartTimeJobLikeModel.task_unit];
        
    }else{
        self.salaryLab.text = @"任务已下线";
    }
//    self.contentLab.text = BPartTimeJobLikeModel.ability_description;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:CPartTimeJobLikeModel.task_user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    //职位标签
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMCLikeIndustryModel *IndustryData in CPartTimeJobLikeModel.task_industry) {
        [industryNameArray addObject:IndustryData.name];
    }
    NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
    self.detailLab.text = industryStr;
    
    
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
- (IBAction)deleteLikeAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(deleteActionWithFavorite_id:)]) {
        JMUserInfoModel *userinfoModel = [JMUserInfoManager getUserInfo];
        NSString *favorite_id;
        if ([userinfoModel.type isEqualToString:C_Type_USER]) {
            if (_cLike_model) {
                
                favorite_id = _cLike_model.favorite_id;
            }
            if (_myCPartTimeJobLikeModel) {
                favorite_id = _myCPartTimeJobLikeModel.favorite_id;
                
            }
        }else if ([userinfoModel.type isEqualToString:B_Type_UESR]){
            if (_bLike_model) {
                favorite_id = _bLike_model.favorite_id;
                
            }
            if (_myBPartTimeJobLikeModel) {
                favorite_id = _myBPartTimeJobLikeModel.favorite_id;
                
            }
            
        }
        

        [_delegate deleteActionWithFavorite_id:favorite_id];
    }
    
}

- (IBAction)chatAction:(UIButton *)sender {
 
    if (_delegate && [_delegate respondsToSelector:@selector(chatActionWithRecipient:foreign_key:)]) {
        [_delegate chatActionWithRecipient:_recipient foreign_key:_foreign_key];
    }
}

@end
