//
//  JMFriendListData.h
//  JMian
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMFriendListData : NSObject

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *friend_avatar;
@property(nonatomic,copy)NSString *friend_phone;
@property(nonatomic,copy)NSString *friend_agency_company_name;
@property(nonatomic,copy)NSString *friend_agency_logo_path;
@property(nonatomic,copy)NSString *friend_agency_company_id;

@property(nonatomic,copy)NSString *friend_nickname;
@property(nonatomic,copy)NSString *friend_company_id;
@property(nonatomic,copy)NSString *friend_user_step;
@property(nonatomic,copy)NSString *friend_enterprise_step;
@property(nonatomic,copy)NSString *friend_user_id;

@end

NS_ASSUME_NONNULL_END
