//
//  JMPartTimeJobModel.m
//  JMian
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPartTimeJobModel.h"

@implementation JMPartTimeJobModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"industry":@"JMIndustryModel",
             @"images":@"JMImageModel"

 
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"user_userId":@"user.user_id",
             @"myDescription":@"description",
             @"user_companyId":@"user_company_id",
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"city_cityId":@"city.city_id",
             @"type_labelId":@"type_label.label_id",
             @"type_name":@"type_label.name",
             @"city_cityName":@"city.city_name",
             
             @"video_file_id":@"video.file_id",
             @"video_type":@"video.type",
             @"video_cover":@"video.cover",
             @"video_file_path":@"video.file_path",
             @"video_status":@"video.status",
             @"video_denial_reason":@"video.denial_reason",
             
             };
}

@end


@implementation JMIndustryModel


@end

@implementation JMImageModel


@end

