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
       
             };
}


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"company_company_name":@"company.company_name",
             @"company_logo_path":@"company.logo_path",
             @"goods_description":@"goods.description",
             @"goods_goods_title":@"goods.goods_title",
             @"goods_goods_price":@"goods.goods_price",
             @"myDescription":@"description",

             };
    
}
@end

@implementation JMCDetailImageModel

 
@end
