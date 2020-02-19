//
//  JMGoodsData.m
//  JMian
//
//  Created by mac on 2020/1/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsData.h"

@implementation JMGoodsData
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"images":@"JMGoodsImageData",
             
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"goods_description":@"description",

    };
}
@end


@implementation JMGoodsImageData

 

@end
