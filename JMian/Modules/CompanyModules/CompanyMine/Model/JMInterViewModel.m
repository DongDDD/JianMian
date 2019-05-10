//
//  JMInterVIewModel.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMInterViewModel.h"
#import <MJExtension.h>

@implementation JMInterViewModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"company_company_name":@"company.company_name",
             @"company_logo_path":@"company.logo_path",
             @"company_company_id":@"company.company_id",

             @"work_status":@"work.status",
             @"work_work_id":@"work.work_id",
             @"work_salary_min":@"work.salary_min",
             @"work_salary_max":@"work.salary_max",
             @"work_work_name":@"work.work_name",
             
             @"candidate_user_id":@"candidate.user_id",
             @"candidate_nickname":@"candidate.nickname",
             @"candidate_avatar":@"candidate.avatar",
         
             @"vita_work_start_date":@"vita.work_start_date",
             @"vita_work_work_status":@"vita.work_work_status",
             @"vita_work_education":@"vita.work_education",
             
             @"interviewer_user_id":@"interviewer.user_id",
             @"interviewer_nickname":@"interviewer.nickname",
             @"interviewer_avatar":@"interviewer.avatar",
             
             
             };
    
}

@end


