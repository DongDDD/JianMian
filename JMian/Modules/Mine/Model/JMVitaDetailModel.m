//
//  JMVitaDetailModel.m
//  JMian
//
//  Created by chitat on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVitaDetailModel.h"
#import <MJExtension.h>

@implementation JMVitaDetailModel

+ (NSDictionary *)mj_objectClassInArray {
   return @{
      @"experiences":@"JMExperiencesModel"
      };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"vita_work_start_date":@"vita.work_start_date",
             @"vita_work_status":@"vita.work_status",
             @"vita_work_education":@"vita.work_education",
             @"vita_work_descriptione":@"vita.work_descriptione",
             @"work_label_id":@"work.label_id",
             @"work_name":@"work.name",
             @"city_city_id":@"city.city_id",
             @"city_city_name":@"city.city_name",
             @"city_label_id":@"city.label_id",
             @"city_is_hot":@"city.is_hot"
             };
}
@end

@implementation JMExperiencesModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"company_id":@"company.company_id",
             @"company_name":@"company.company_name",
             @"work_label_id":@"work.label_id",
             @"work_name":@"work_name",
             @"shielding_id":@"shielding.shielding_id",
             @"shielding_company":@"shielding.company",
             @"shielding_company_id":@"shielding.company_id",
             @"shielding_company_name":@"shielding.company_name",
             @"education_id":@"education.education_id",
             @"education":@"education.education",
             @"education_major":@"education.major",
             @"education_s_date":@"education.s_date",
             @"education_e_date":@"education.e_date",
             @"education_description":@"education.description",
             @"school_name":@"school.school_name"
             };
}
@end
