//
//  JMCommentCellData.m
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCommentCellData.h"

@implementation JMCommentCellData

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"myDescription":@"description",
             @"user_reputation":@"user.reputation",
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"task_title":@"task.task_title",
             @"company_company_name":@"company.company_name",
             @"company_logo_path":@"company.logo_path",

             };
    
}

@end
