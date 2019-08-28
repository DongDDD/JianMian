//
//  JMCDetailModel.m
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailModel.h"

@implementation JMCDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"images":@"JMCDetailImageModel",
             @"industry":@"JMCDetailindustryModel",
             @"video":@"JMCDetailVideoModel",

             };
}


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"company_company_name":@"company.company_name",
             @"company_logo_path":@"company.logo_path",
             @"company_reputation":@"company.reputation",
         
             @"goods_description":@"goods.description",
             @"goods_goods_title":@"goods.goods_title",
             @"goods_goods_price":@"goods.goods_price",
             @"myDescription":@"description",
             @"type_label_id":@"type_label.label_id",
             @"type_label_name":@"type_label.name",

             @"user_id":@"user.user_id",
             @"user_nickname":@"user.nickname",
             @"user_company_id":@"user.company_id",
             @"user_avatar":@"user.avatar",
             @"city_id":@"city.city_id",
             @"city_name":@"city.city_name",
             @"video_file_path":@"video.file_path",
             @"video_cover":@"video.cover",


             };

}
@end

@implementation JMCDetailImageModel

 
@end

@implementation JMCDetailindustryModel


@end

//@implementation JMCDetailVideoModel
//
//
//@end
