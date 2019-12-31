//
//  JMPostIMProfileAction.h
//  JMian
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImSDK/TIMFriendshipDefine.h>
#import "JMUserInfoManager.h"
#import "JMUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMPostIMProfileAction : NSObject

+(void)postIMProfileActionWithUserModel:(JMUserInfoModel *)userModel;
@end

NS_ASSUME_NONNULL_END
