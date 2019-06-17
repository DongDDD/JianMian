//
//  JMPartTimeJobLikeModel.m
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBPartTimeJobLikeModel.h"

@implementation JMBPartTimeJobLikeModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"ability_industry":@"JMBLikeIndustryModel",
             
             };
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ability_type_label_name":@"ability.type_label.name",
             @"ability_typeLabel_id":@"ability.type_label.label_id",
             @"ability_description":@"ability.description",
             @"ability_ability_id":@"ability.ability_id",
             @"ability_industry":@"ability.industry",

             @"ability_user_reputation":@"ability.user.reputation",
             @"ability_user_user_id":@"ability.user.user_id",
             @"ability_user_nickname":@"ability.user.nickname",
             @"ability_user_company_id":@"ability.user.company_id",
             @"ability_user_avatar":@"ability.user.avatar",
      

             };
}
@end

@implementation JMBLikeIndustryModel

@end
