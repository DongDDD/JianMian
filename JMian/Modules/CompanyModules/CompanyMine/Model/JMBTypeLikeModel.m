//
//  JMBTypeLikeModel.m
//  JMian
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBTypeLikeModel.h"

@implementation JMBTypeLikeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"job_user_id":@"job.user_id",
             @"job_salary_min":@"job.salary_min",
             @"job_salary_max":@"job.salary_max",
             @"job_user_nickname":@"job.user.nickname",
             @"job_user_avatar":@"job.user.avatar",
             @"job_vita_education":@"job.vita.education",
             @"job_vita_description":@"job.vita.description",
             @"job_work_name":@"job.work.name",
             @"user_user_id":@"user.user_id",
             @"user_email":@"user.email",
             @"user_phone":@"user.phone",
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar"
             };
}

@end
