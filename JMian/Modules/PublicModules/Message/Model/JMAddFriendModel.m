//
//  JMFriendListModel.m
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAddFriendModel.h"

@implementation JMAddFriendModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{

             @"agency_company_name":@"agency.company_name",
             @"agency_logo_path":@"agency.logo_path",
             @"agency_company_id":@"agency.company_id",
             
             @"amigo_type":@"amigo.type",
             @"amigo_friend_id":@"amigo.friend_id",

             };
    
}

@end
