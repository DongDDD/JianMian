//
//  JMTaskListCellData.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskListCellData.h"
#import <MJExtension.h>

@implementation JMTaskListCellData
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"type_labelID":@"type_label.label_id",
             @"type_labelName":@"type_label.name",
             @"companyiId":@"company.company_id",
             @"companyLogo_path":@"company.logo_path",
             
             @"cityID":@"city.city_id",
             @"cityName":@"city.city_name",
             
             @"goodsTitle":@"goods.goods_title",
             @"goodsPrice":@"goods.goods_price",
             @"goodsDescription":@"goods.description",
             };
}

@end
