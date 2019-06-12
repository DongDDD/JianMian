//
//  JMUserInfoModel.m
//  JMian
//
//  Created by chitat on 2019/4/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserInfoModel.h"
#import <MJExtension.h>

@implementation JMUserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"realName":@"real.name",
             @"realSex":@"real.sex",
             @"realBirthday":@"real.birthday",
             @"realStatus":@"real.status",
             
              @"card_status":@"card.status",
              @"card_sex":@"card.sex",
              @"card_ethnic":@"card.ethnic",
              @"card_name":@"card.name",
              @"card_birthday":@"card.birthday",
              @"card_denial_reason":@"card.denial_reason",
             
             @"companyReg_address":@"company_real.reg_address",
             @"companyPosition":@"company_real.company_position",
             @"companyReal_id":@"company_real.company_real_id",
             @"companyId":@"company_real.company_id",
             @"companyCorporate":@"company_real.corporate",
             @"companyUser_id":@"company_real.user_id",
             @"companyName":@"company_real.company_name"

             };
}

@end
