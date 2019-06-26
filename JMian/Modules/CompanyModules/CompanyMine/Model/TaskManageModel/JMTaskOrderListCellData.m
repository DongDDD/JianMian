//
//  JMTaskOrderListCellData.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskOrderListCellData.h"

@implementation JMTaskOrderListCellData
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"industry":@"JMTaskOrderIndustryModel",
             @"snapshot_images":@"JMTaskOrderImageModel"
         
             };
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"boss_user_id":@"boss.user_id",
             @"boss_company_id":@"boss.company_id",
             @"boss_nickname":@"boss.nickname",
             @"boss_avatar":@"boss.avatar",
             
             @"user_user_id":@"user.user_id",
             @"user_company_id":@"user.company_id",
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"snapshot_change":@"snapshot.snapshot_change",

   
             @"goodsTitle":@"goods.goods_title",
             @"goodsPrice":@"goods.goods_price",
             @"goodsDescription":@"goods.description",

             @"snapshot_task_id":@"snapshot.task_id",
             @"snapshot_type_label_id":@"snapshot.type_label_id",
             @"snapshot_user_id":@"snapshot.user_id",
             @"snapshot_task_title":@"snapshot.task_title",
             @"snapshot_payment_method":@"snapshot.payment_method",
             @"snapshot_unit":@"snapshot.unit",
             @"snapshot_payment_money":@"snapshot.payment_money",
             @"snapshot_front_money":@"snapshot.front_money",
             @"snapshot_quantity_max":@"snapshot.quantity_max",
             @"snapshot_deadline":@"snapshot.deadline",
             @"snapshot_deadline":@"snapshot.description",
             @"snapshot_deadline":@"snapshot.address",
             @"snapshot_deadline":@"snapshot.longitude",
             @"snapshot_deadline":@"snapshot.latitude",
             @"snapshot_status":@"snapshot.status",
             @"snapshot_cityId":@"snapshot.city.city_id",
             @"snapshot_cityName":@"snapshot.city.city_name",

             @"snapshot_companyID":@"snapshot.company.company_id",
             @"snapshot_companyName":@"snapshot.company.company_name",
             @"snapshot_companyLogo_path":@"snapshot.company.logo_path",
             @"snapshot_reputation":@"snapshot.company.reputation",
             @"snapshot_user_nickname":@"snapshot.user.nickname",
             @"snapshot_user_avatar":@"snapshot.user.avatar",
             @"snapshot_share_url":@"snapshot.share_url",
             @"snapshot_images":@"snapshot.images",

             };
}

@end

@implementation JMTaskOrderIndustryModel




@end

@implementation JMTaskOrderImageModel




@end
