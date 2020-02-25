//
//  JMSpecialManager.m
//  JMian
//
//  Created by mac on 2020/2/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMLaunchInfoManager.h"
#import "DimensMacros.h"
#import <YYCache/YYCache.h>
#define CacheName @"JMCache"

@implementation JMLaunchInfoManager

+ (JMLaunchModel *)getLaunchInInfo {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    id value = [yyCache objectForKey:@"launch"];
    return [JMLaunchModel mj_objectWithKeyValues:value];
}


+ (void)saveVersionInfo:(JMLaunchModel *)model {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    [yyCache setObject:model.mj_keyValues forKey:@"launch"];
}
@end
