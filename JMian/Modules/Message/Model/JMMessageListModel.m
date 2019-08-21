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

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"job_industry":@"JMChatInfoIndustry",
             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"sender_user_id":@"sender.user_id",
             @"sender_type":@"sender.type",
             @"sender_avatar":@"sender.avatar",
             @"sender_nickname":@"sender.nickname",
             @"sender_company_position":@"sender.company_position",
             @"sender_phone":@"sender.phone",

             @"recipient_user_id":@"recipient.user_id",
             @"recipient_type":@"recipient.type",
             @"recipient_avatar":@"recipient.avatar",
             @"recipient_nickname":@"recipient.nickname",
             @"recipient_company_position":@"recipient.company_position",
             @"recipient_phone":@"recipient.phone",

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
             @"job_user_job_id":@"job.user_job_id",

             @"work_task_id":@"work.task_id",
             @"work_task_title":@"work.task_title",
             @"work_payment_method":@"work.payment_method",
             @"work_unit":@"work.unit",
             @"work_payment_money":@"work.payment_money",
             @"work_front_money":@"work.front_money",
             @"work_quantity_max":@"work.quantity_max",
             @"workInfo_employee":@"workInfo.employee",
             @"work_deadline":@"work.deadline",
             @"work_mydDscription":@"work.Dscription",
             @"work_address":@"work.address",
             @"work_status":@"work.status",
             @"work_goods":@"work.goods",
             @"work_type_label_label_id":@"work.type_label.label_id",
             @"work_type_label_name":@"work.type_label.name",
             
             @"job_ability_id":@"job.ability_id",
             @"job_description":@"job.description",
             @"job_status":@"job.status",
             @"job_look":@"job.look",
             @"job_user_user_id":@"job.user.user_id",
             @"job_user_company_id":@"job.user.company_id",
             @"job_user_nickname":@"job.user.nickname",
             @"job_user_avatar":@"job.user.avatar",
             @"job_user_reputation":@"job.user.reputation",
             @"job_type_label_label_id":@"job.type_label.label_id",
             @"job_type_label_name":@"job.type_label.name",
             @"job_industry":@"job.industry"

             };
    
}

@end

@implementation JMChatInfoIndustry



@end

