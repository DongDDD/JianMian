//
//  JMInterVIewModel.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMInterVIewModel.h"
#import <MJExtension.h>

@implementation JMInterVIewModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"company_company_name":@"company.company_name",
             @"company_logo_path":@"company.logo_path",
             
             @"work_work_name":@"work.work_name",
             @"work_salary_min":@"work.salary_min",
             @"work_salary_max":@"work.salary_max",
             
             @"interviewer_work_name":@"interviewer.work_name",
             @"interviewer_avatar":@"interviewer.avatar",
             
             @"candidate_nickname":@"candidate.nickname",
             @"candidate_avatar":@"candidate.avatar"
         
             };
    
}

@end
