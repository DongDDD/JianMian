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
    
    NSString *astep = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"astep"];
    NSString *bstep = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"bstep"];
    NSString *gsid = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"gsid"];
    NSString *gsname = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"gsname"];
    NSString *jianzhi = [TIMProfileTypeKey_Custom_Prefix stringByAppendingString:@"jianzhi"];

    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{astep:userModel.user_step} succ:nil fail:nil];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{bstep:userModel.enterprise_step} succ:nil fail:nil];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{gsid:userModel.company_id} succ:nil fail:nil];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{gsname:userModel.company_real_company_name} succ:nil fail:^(int code, NSString *msg) {
        NSLog(@"%@",msg);
        
    }];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{jianzhi:userModel.ability_count} succ:nil fail:nil];

    
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_FaceUrl:userModel.avatar}
      succ:nil fail:nil];
    [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_Nick:userModel.nickname} succ:nil fail:nil];
}

@end
