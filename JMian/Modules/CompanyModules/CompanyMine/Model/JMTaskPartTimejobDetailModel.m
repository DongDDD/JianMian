//
//  JMTaskPartTimejobDetailModel.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskPartTimejobDetailModel.h"
#import <MJExtension.h>


@implementation JMTaskPartTimejobDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"images":@"JMImageModel",
             @"industry":@"JMTaskIndustryModel"

             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"type_labelID":@"type_label.label_id",
             @"type_labelName":@"type_label.name",
             
             @"user_user_id":@"user.user_id",
             @"user_company_id":@"user.company_id",
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"cityID":@"city.city_id",
             @"cityName":@"city.city_name",

             @"companyiId":@"company.company_id",
             @"companyName":@"company.company_name",
             
             @"goodsTitle":@"goods.goods_title",
             @"goodsPrice":@"goods.goods_price",
             @"goodsDescription":@"goods.description",
             
             @"video_file_id":@"video.file_id",
             @"video_type":@"video.type",
             @"video_cover":@"video.cover",
             @"video_file_path":@"video.file_path",
             @"video_status":@"video.status",
             @"video_denial_reason":@"video.denial_reason"
             };
}



@end

@implementation JMTaskIndustryModel


@end


