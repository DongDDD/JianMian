//
//  JMCityListManager.m
//  JMian
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCityListManager.h"
#import "DimensMacros.h"
#import <YYCache/YYCache.h>

#define CacheName @"JMCache"

@implementation JMCityListManager
+ (id)getCityListInfo {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    NSArray *value = [yyCache objectForKey:@"listData"];
    return value;
}


+ (void)saveCityListData:(NSArray *)listArray {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    [yyCache setObject:listArray forKey:@"listData"];
}
@end
