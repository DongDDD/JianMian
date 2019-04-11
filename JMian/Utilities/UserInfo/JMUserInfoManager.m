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

@implementation JMUserInfoManager

+ (JMUserInfoModel *)getUserInfo {
    YYCache *yyCache = [YYCache cacheWithName:@"JMCache"];
    id value = [yyCache objectForKey:@"userINfo"];
    return [JMUserInfoModel mj_objectWithKeyValues:value];
}

+ (void)saveUserInfo:(NSDictionary *)userInfoDic {
    YYCache *yyCache = [YYCache cacheWithName:@"JMCache"];
    [yyCache setObject:userInfoDic forKey:@"userInfo"];
}
@end
