//
//  JMUserInfoManager.m
//  JMian
//
//  Created by chitat on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserInfoManager.h"
#import "DimensMacros.h"
#import <YYCache/YYCache.h>

#define CacheName @"JMCache"

@implementation JMUserInfoManager

+ (JMUserInfoModel *)getUserInfo {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    id value = [yyCache objectForKey:@"userInfo"];
    return [JMUserInfoModel mj_objectWithKeyValues:value];
}


+ (void)saveUserInfo:(JMUserInfoModel *)model {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    [yyCache setObject:model.mj_keyValues forKey:@"userInfo"];
}

@end
