//
//  JMFriendListModel.h
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMAddFriendModel : NSObject

@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *agency_company_name;
@property(nonatomic,copy)NSString *agency_logo_path;
@property(nonatomic,copy)NSString *agency_company_id;

@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *company_id;
@property(nonatomic,copy)NSString *user_step;
@property(nonatomic,copy)NSString *enterprise_step;
@property(nonatomic,copy)NSString *user_id;


@end

NS_ASSUME_NONNULL_END
