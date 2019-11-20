//
//  JMVideoListCellData.m
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoListCellData.h"

@implementation JMVideoListCellData

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"labels":@"JMCVideoLabsModel",
             @"video":@"JMCVideoModel"
             };
}


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"user_user_id":@"user.user_id",
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"user_reputation":@"user.reputation",
             
             @"vita_work_start_date":@"vita.work_start_date",
             @"vita_work_status":@"vita.work_status",
             @"vita_education":@"vita.education",
             @"vita_description":@"vita.description",

             @"work_label_id":@"work.label_id",
             @"work_name":@"work.name",
    
             @"video_user_id":@"video.user_id",
             @"video_type":@"video.type",
             @"video_file_path":@"video.file_path",
             @"video_file_id":@"video.file_id",
             @"vita_description":@"vita.description",
             @"video_file_path":@"video.file_path",
             @"video_status":@"video.status",
             @"video_denial_reason":@"video.denial_reason",
             @"video_cover":@"video.cover",
             
             @"city_city_id":@"city.city_id",
             @"city_city_name":@"city.city_name",

             
             };
    
}


@end

@implementation JMCVideoLabsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"pivot_company_id":@"pivot.company_id",
             @"pivot_label_id":@"pivot.label_id",
             
             };
    
}

@end

@implementation JMCVideoModel

@end

