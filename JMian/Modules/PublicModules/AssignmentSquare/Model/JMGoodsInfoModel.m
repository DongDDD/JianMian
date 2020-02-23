//
//  JMGoodInfoModel.m
//  JMian
//
//  Created by mac on 2020/1/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsInfoModel.h"

@implementation JMGoodsInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"images":@"JMGoodsInfoImageModel",
             @"sku":@"JMGoodsInfoSkuModel",

             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"goods_description":@"description",
             @"video_file_path":@"video.file_path",
             @"video_file_id":@"video.file_id",
             @"video_cover_path":@"video.cover_path",
             @"shop_user_id":@"shop.user_id",

             };
    
}


@end

@implementation JMGoodsInfoImageModel


@end
@implementation JMGoodsInfoSkuModel


@end

