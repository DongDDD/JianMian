//
//  JMMessageListModel.m
//  JMian
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageListModel.h"
#import <MJExtension.h>


@implementation JMMessageListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"sender_user_id":@"sender.user_id",
             @"sender_type":@"sender.type",
             @"sender_avatar":@"sender.avatar",
             @"sender_nickname":@"sender.nickname",
             @"sender_company_position":@"sender.company_position",
             
             @"recipient_user_id":@"recipient.user_id",
             @"recipient_type":@"recipient.type",
             @"recipient_avatar":@"recipient.avatar",
             @"recipient_nickname":@"recipient.nickname",
             @"recipient_company_position":@"recipient.company_position",
        
             @"work_work_id":@"work.work_id",
             @"work_description":@"work.description",
             @"work_salary_max":@"work.salary_max",
             @"work_salary_min":@"work.salary_min",
             @"work_work_name":@"work.work_name",
             @"work_work_experience_max":@"work.work_education",
             @"work_work_experience_min":@"work.work_experience_min",
             @"work_work_experience_max":@"work.work_experience_max",
             
             @"workInfo_company_name":@"work.info.company_name",
             @"workInfo_financing":@"work.info.financing",
             @"workInfo_company_id":@"work.info.company_id",
             @"workInfo_logo_path":@"work.info.logo_path",
             @"workInfo_industry":@"work.info.industry",
             @"workInfo_employee":@"work.info.employee",
             @"workInfo_industry_label_id":@"work.info.industry_label_id",
             @"job_user_job_id":@"job.user_job_id"

             };
    
}

@end


