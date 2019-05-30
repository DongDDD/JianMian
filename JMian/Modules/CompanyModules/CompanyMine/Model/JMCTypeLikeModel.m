//
//  JMCTypeLikeModel.m
//  JMian
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCTypeLikeModel.h"

@implementation JMCTypeLikeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"work_salary_min":@"work.salary_min",
             @"work_salary_max":@"work.salary_max",
             @"work_description":@"work.description",
             @"work_work_name":@"work.work_name",
             @"work_address":@"work.address",
             @"work_company_logo_path":@"work.company.logo_path",
             @"work_company_company_name":@"work.company.company_name"
             };
}

@end
