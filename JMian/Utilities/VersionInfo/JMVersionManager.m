//
//  JMVersionManager.m
//  JMian
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVersionManager.h"
#import "DimensMacros.h"
#import <YYCache/YYCache.h>

#define CacheName @"JMCache"

@implementation JMVersionManager
+ (JMVersionModel *)getVersoinInfo {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    id value = [yyCache objectForKey:@"versionInfo"];
    return [JMVersionModel mj_objectWithKeyValues:value];
}


+ (void)saveVersionInfo:(JMVersionModel *)model {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    [yyCache setObject:model.mj_keyValues forKey:@"versionInfo"];
}

@end
