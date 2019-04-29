//
//  JMMessageListModel.m
//  JMian
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageListModel.h"
#import <MJExtension.h>


@implementation JMMessageListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"sender_user_id":@"sender.user_id",
             @"sender_type":@"sender.type",
             @"sender_avatar":@"sender.avatar",
             @"sender_nickname":@"sender.nickname",
             @"sender_company_position":@"sender.company_position",
             
             @"recipient_user_id":@"recipient.user_id",
             @"recipient_type":@"recipient.type",
             @"recipient_avatar":@"recipient.avatar",
             @"recipient_nickname":@"recipient.nickname",
             @"recipient_company_position":@"recipient.company_position",
             
             @"work_work_name":@"work.work_name"

             };
    
}

@end
