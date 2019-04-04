//
//  JMLoginInfoModel.h
//  JMian
//
//  Created by mac on 2019/4/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMLoginInfoModel : NSObject


@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *user_step;
@property (nonatomic, copy) NSString *enterprise_step;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *real;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *usersig;

@end

NS_ASSUME_NONNULL_END
