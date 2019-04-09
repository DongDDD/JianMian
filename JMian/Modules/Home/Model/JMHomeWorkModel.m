//
//  JMHomeWorkModel.m
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHomeWorkModel.h"
#import <MJExtension.h>


@implementation JMHomeWorkModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"Description":@"description",
             @"cityId":@"city.city_id",
             @"cityName":@"city.city_name",
             @"companyId":@"company.company_id",
             @"companyName":@"company.company_name",
             @"companyLogo_path":@"company.logo_path"
             };
    
}

@end
