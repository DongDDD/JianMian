//
//  JMUserInfoModel.h
//  JMian
//
//  Created by chitat on 2019/4/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMUserInfoModel : NSObject

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *user_step;
@property (nonatomic, copy) NSString *enterprise_step;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *realSex;
@property (nonatomic, copy) NSString *realBirthday;
@property (nonatomic, copy) NSString *realStatus;
@property (nonatomic, copy) NSString *usersig;


@end

NS_ASSUME_NONNULL_END
