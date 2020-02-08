//
//  JMOrderCellData.m
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMOrderCellData.h"

@implementation JMOrderCellData

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"snapshot_images":@"JMSnapshotImageModel"
             };
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"snapshot_task_id":@"snapshot.task_id",
             @"snapshot_company_company_id":@"snapshot.company.company_id",
             @"snapshot_company_logo_path":@"snapshot.company.logo_path",
             @"snapshot_company_reputation":@"snapshot.company.reputation",
             @"snapshot_company_company_name":@"snapshot.company.company_name",
             @"snapshot_images":@"snapshot.images",

             @"snapshot_goods_goods_title":@"snapshot.goods.goods_title",
             @"snapshot_goods_goods_price":@"snapshot.goods.goods_price",
             @"snapshot_goods_description":@"snapshot.goods.description",

             @"snapshot_video_file_id":@"snapshot.video.file_id",
             @"snapshot_video_type":@"snapshot.video.type",
             @"snapshot_video_cover":@"snapshot.video.cover",
             @"snapshot_video_file_path":@"snapshot.video.file_path",
             @"snapshot_video_status":@"snapshot.video.status",
             @"snapshot_video_denial_reason":@"snapshot.video.denial_reason",
             @"snapshot_video_look":@"snapshot.video.look",
    
             @"referrer_user_id":@"referrer.user_id",
             @"referrer_phone":@"referrer.phone",
             @"referrer_nickname":@"referrer.nickname",
             @"referrer_avatar":@"referrer.avatar",
             @"referrer_reputation":@"referrer.reputation",
             
             @"boss_reputation":@"boss.reputation",
             @"boss_user_id":@"boss.user_id",
             @"boss_nickname":@"boss.nickname",
             @"boss_company_id":@"boss.company_id",
             @"boss_avatar":@"boss.avatar",
             

             @"city_city_id":@"city.city_id",
             @"city_city_name":@"city.city_name",
             @"city_name_relation":@"city.name_relation",
             
             @"company_company_id":@"company_company_id",
             @"company_company_name":@"company_company_name",
             @"company_logo_path":@"company_logo_path",
             @"company_reputation":@"company_reputation",
             @"logistics_label_id":@"logistics.label_id",
             @"logistics_name":@"logistics.name",
             @"shop_shop_name":@"shop.shop_name",
             @"shop_user_id":@"shop.user_id",


             
             };
}





@end


@implementation JMSnapshotImageModel



@end
