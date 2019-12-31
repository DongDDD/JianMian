//
//  JMPostIMProfileAction.m
//  JMian
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostIMProfileAction.h"


@implementation JMPostIMProfileAction

+(void)postIMProfileActionWithUserModel:(JMUserInfoModel *)userModel{
    
    NSString *user_id = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"user_id"];
    NSString *user_step = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"user_step"];
    NSString *enterprise_step = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"enterprise_step"];
    NSString *phone = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"phone"];
    NSString *company_id = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"company_id"];
    NSString *company_name = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"company_name"];
    
//    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{user_id:userModel.user_id} succ:nil fail:nil];
//    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{user_step:userModel.user_step} succ:nil fail:nil];
//    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{enterprise_step:userModel.enterprise_step} succ:nil fail:nil];
//    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{phone:userModel.phone} succ:nil fail:nil];
//    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{company_id:userModel.company_id} succ:nil fail:nil];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{company_name:userModel.company_real_company_name} succ:nil fail:nil];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_FaceUrl:userModel.avatar}
      succ:nil fail:nil];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_Nick:userModel.nickname} succ:nil fail:nil];

    
}

@end
