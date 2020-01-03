//
//  JMFriendListData.m
//  JMian
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMFriendListData.h"

@implementation JMFriendListData

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{
        @"friend_avatar":@"friend.avatar",
        @"friend_phone":@"friend.phone",
        @"friend_nickname":@"friend.nickname",
        @"friend_company_id":@"friend.company_id",
        @"friend_user_step":@"friend.user_step",
        @"friend_enterprise_step":@"friend.enterprise_step",
        @"friend_user_id":@"friend.user_id",
        @"friend_ability_count":@"friend.ability_count",

        
        @"friend_agency_company_name":@"friend.agency.company_name",
        @"friend_agency_logo_path":@"friend.agency.logo_path",
        @"friend_agency_company_id":@"friend.agency.company_id",
        
    };
    
}


@end
