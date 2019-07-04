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
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"files":@"JMComFilesModel",
             
             };
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"Description":@"description",
             @"cityId":@"city.city_id",
             @"cityName":@"city.city_name",
            
             @"companyId":@"company.company_id",
             @"companyName":@"company.company_name",
             @"companyLogo_path":@"company.logo_path",
             @"companyFinancing":@"company.financing",
             @"companyEmployee":@"company.employee",
             @"companyCityId":@"company.city_id",
             @"companyAddress":@"company.address",
             @"companyLongitude":@"company.longitude",
             @"companyLatitude":@"company.latitude",
             @"companyAddress":@"company.address",
             @"companyLabels":@"company.labels",
             
             @"companyIndustry_label":@"company.address",
             @"companyCity":@"company.labels",
     
             @"videoCompanyId":@"video.company_id",
             @"videoFile_path":@"video.file_path",
             @"videoStatus":@"video.status",
             @"videoDenial_reason":@"video.denial_reason",
             
             @"user_avatar":@"user.avatar",
             @"user_nickname":@"user.nickname"
             };
    
}

@end


@implementation JMComFilesModel

 

@end
