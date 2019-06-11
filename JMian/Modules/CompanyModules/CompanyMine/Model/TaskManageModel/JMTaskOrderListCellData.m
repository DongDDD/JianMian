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
             @"industry":@"JMTaskOrderIndustryModel"
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
             
             };
}


@end

@implementation JMTaskOrderIndustryModel


@end
