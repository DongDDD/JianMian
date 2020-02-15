//
//  JMOrderInfoModel.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderInfoModel.h"

@implementation JMOrderInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"goods":@"JMGoodsCellData",

             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"after_sale_record_id":@"after_sale.record_id",
             @"after_sale_message":@"after_sale.message",
             @"after_sale_user_id":@"after_sale.user_id",
             @"after_sale_boss_id":@"after_sale.boss_id",
             @"after_sale_created_at":@"after_sale.created_at",
             };
}


@end
@implementation JMGoodsCellData
@end
