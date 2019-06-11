//
//  JMTaskGoodsDetailModel.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskGoodsDetailModel.h"

@implementation JMTaskGoodsDetailModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"images":@"JMImageModel",

             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"companyiId":@"company.company_id",
             @"companyLogo_path":@"company.logo_path",
             
             @"goodsTitle":@"goods.goods_title",
             @"goodsPrice":@"goods.goods_price",
             @"goodsDescription":@"goods.description",
             
             @"video_file_id":@"video.file_id",
             @"video_type":@"video.type",
             @"video_cover":@"video.cover",
             @"video_file_path":@"video.file_path",
             @"video_status":@"video.status",
             @"video_denial_reason":@"video.denial_reason",
             };
}

@end
