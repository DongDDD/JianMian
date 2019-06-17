//
//  JMCPartTimeJobLikeModel.m
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCPartTimeJobLikeModel.h"

@implementation JMCPartTimeJobLikeModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"task_industry":@"JMCLikeIndustryModel",
             
             };
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ 
             @"task_payment_method":@"task.payment_method",
             @"task_quantity_max":@"task.quantity_max",
             @"task_task_title":@"task.task_title",
             @"task_front_money":@"task.front_money",
             @"task_unit":@"task.unit",

             @"company_company_name":@"task.company.company_name",
             @"company_logo_path":@"task.company.logo_path",
             @"company_company_id":@"task.company.company_id",
             @"company_reputation":@"task.company.reputation",
             
             @"task_payment_money":@"task.payment_money",
             @"task_deadline":@"task.deadline",
             @"task_status":@"task.status",
             
             @"task_user_reputation":@"task.user.reputation",
             @"task_user_user_id":@"task.user.user_id",
             @"task_user_nickname":@"task.user.nickname",
             @"task_user_company_id":@"task.user.company_id",
             @"task_user_avatar":@"task.user.avatar",

             };
}


@end


@implementation JMCLikeIndustryModel

@end
