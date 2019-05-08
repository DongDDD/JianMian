//
//  JMBankCardData.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBankCardData.h"
#import <MJExtension.h>

@implementation JMBankCardData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"user_user_id":@"user.user_id",
             @"user_avatar":@"user.avatar",
             @"user_nickname":@"user.nickname",
             @"user_phone":@"user.phone",
             };
}

@end
