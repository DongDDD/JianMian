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
             
             @"myDescription":@"description",
             @"vita_status":@"vita.status",
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
             @"video_cover":@"video.cover",          
             @"favorites_favorite_id":@"favorites.favorite_id",
             @"city_is_hot":@"city.is_hot",
             
             @"real_sex":@"real.sex",
             @"real_ethnic":@"real.ethnic",
             @"real_name":@"real.name",
             @"real_birthday":@"real.birthday",
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
