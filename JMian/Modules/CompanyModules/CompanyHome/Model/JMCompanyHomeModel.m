//
//  JMCompanyHomeModel.m
//  JMian
//
//  Created by mac on 2019/4/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyHomeModel.h"

@implementation JMCompanyHomeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"userNickname":@"user.nickname",
             @"userAvatar":@"user.avatar",
             
             @"vitaWork_start_date":@"vita.work_start_date",
             @"vitaWork_status":@"vita.work_status",
             @"vitaEducation":@"vita.education",
             
             @"workLabel_id":@"work.label_id",
             @"workName":@"work.name",
             
             @"cityCity_id":@"city.city_id",
             @"cityCity_name":@"city.city_name",
             @"cityIs_hot":@"city.is_hot",
             
             @"video_file_path":@"video.file_path",
             @"video_status":@"video.status"
             };

}

@end
