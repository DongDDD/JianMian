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
    _cLike_model = CTypeLikeModel;
    self.nameLab.text = CTypeLikeModel.work_company_company_name;
    self.contentLab.text = CTypeLikeModel.work_description;
    self.salaryLab.text = [self getSalaryStrWithMin:CTypeLikeModel.work_salary_min max:CTypeLikeModel.work_salary_max];
//    NSString *eduStr = [self getEducationStrWithEducation:CTypeLikeModel.ed];
//    NSString *detailStr = [NSString stringWithFormat:@"%@/%@",eduStr,CTypeLikeModel.job_work_name];
    
    self.detailLab.text = CTypeLikeModel.work_address;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:CTypeLikeModel.work_company_logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
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




//C端面试列表状态
-(void)init_C_TypeViewWith:(NSString *)status
{
    
    
    
}


//C端面试列表状态
-(void)init_B_TypeViewWith:(NSString *)status
{
    
    
    
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
            favorite_id = _cLike_model.favorite_id;
            
        }else if ([userinfoModel.type isEqualToString:B_Type_UESR]){
            favorite_id = _bLike_model.favorite_id;

            
        }
        

        [_delegate deleteActionWithFavorite_id:favorite_id];
    }
    
}

- (IBAction)chatAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(chatAction)]) {
        [_delegate chatAction];
    }
}

@end
