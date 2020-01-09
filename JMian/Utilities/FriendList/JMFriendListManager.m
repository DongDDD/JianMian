//
//  JMFriendListManager.m
//  JMian
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMFriendListManager.h"
#import "DimensMacros.h"
#import <YYCache/YYCache.h>
#define CacheName @"JMCache"

@implementation JMFriendListManager
+(NSMutableArray *)getFriendList{
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    NSMutableArray *value = [yyCache objectForKey:@"friendList"];
    return value;
    
}

+(void)saveFriendList:(NSMutableArray<TCommonContactSelectCellData *> *)friends {
    YYCache *yyCache = [YYCache cacheWithName:CacheName];
    [yyCache setObject:friends forKey:@"friendList"];
}

@end
