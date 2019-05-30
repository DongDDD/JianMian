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
      @"experiences":@"JMExperiencesModel",
      @"shielding":@"JMShieldingModel",
      @"learning":@"JMLearningModel",
      @"jobs":@"JMMyJobsModel",
      @"education":@"JMEducationModel",
      @"files":@"JMMyFilesModel"
      };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"user_email":@"user.email",
             @"user_phone":@"user.phone",
             @"vita_work_start_date":@"vita.work_start_date",
             @"vita_education":@"vita.education",
             @"vita_description":@"vita.description",
             @"work_label_id":@"work.label_id",
             @"work_name":@"work.name",
             @"city_city_id":@"city.city_id",
             @"city_city_name":@"city.city_name",
             @"city_label_id":@"city.label_id",             
             @"video_file_path":@"video.file_path",
             @"video_status":@"video.status",
             @"video_type":@"video.type",
             @"favorites_favorite_id":@"favorites.favorite_id",
             @"city_is_hot":@"city.is_hot"
             };
}

@end

@implementation JMMyJobsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"work_name":@"work.name",
             @"city_city_name":@"city.city_name",

             };
}

@end

@implementation JMExperiencesModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"company_id":@"company.company_id",
             @"company_name":@"company.company_name",
             @"work_label_id":@"work.label_id",
             @"work_name":@"work.name",
             @"experiences_description":@"description"
             };
    
//    return @{
//             @"company_id":@"company.company_id",
//             @"company_name":@"company.company_name",
//             @"work_label_id":@"work.label_id",
//             @"work_name":@"work.name",
//             @"shielding_id":@"shielding.shielding_id",
//             @"shielding_company":@"shielding.company",
//             @"shielding_company_id":@"shielding.company_id",
//             @"shielding_company_name":@"shielding.company_name",
//             @"education_id":@"education.education_id",
//             @"education":@"education.education",
//             @"education_major":@"education.major",
//             @"education_s_date":@"education.s_date",
//             @"education_e_date":@"education.e_date",
//             @"education_description":@"education.description",
//             @"school_name":@"school.school_name"
//             };
    
}


@end

@implementation JMShieldingModel


@end

@implementation JMLearningModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"education_description":@"description",
             @"school_name":@"school.school_name"
             };
}

@end


@implementation JMMyFilesModel


@end


@implementation JMEducationModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"school_school_name":@"school.school_name"
             };
}

@end
