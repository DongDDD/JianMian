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
             
             @"company_real_reg_address":@"company_real.reg_address",
             @"company_real_company_position":@"company_real.company_position",
             @"company_real_company_real_id":@"company_real.company_real_id",
             @"company_real_company_id":@"company_real.company_id",
             @"company_real_corporate":@"company_real.corporate",
             @"company_real_company_name":@"company_real.company_name",
             @"company_real_business_scope":@"company_real.business_scope",
             @"company_real_reg_date":@"company_real.reg_date",
             @"company_real_denial_reason":@"company_real.denial_reason",
             @"company_real_unified_credit_code":@"company_real.unified_credit_code",
             @"company_real_status":@"company_real.status",
             @"company_real_reg_capital":@"company_real.reg_capital",

             @"shop_address":@"shop.address_address",
             @"shop_description":@"shop.description",
             @"shop_logo":@"shop.shop_logo",
             @"shop_name":@"shop.shop_name",
             @"shop_business_hours_start":@"shop.business_hours_start",
             @"shop_poster":@"shop.shop_poster",
             @"shop_phone":@"shop.shop_phone",
             @"shop_business_hours_end":@"shop.business_hours_end",
             @"shop_area_id":@"shop.area_id",
             @"shop_sort":@"shop.sort",
             @"shop_status":@"shop.status",
             @"shop_shop_id":@"shop.shop_id",

        
             };
}

@end
