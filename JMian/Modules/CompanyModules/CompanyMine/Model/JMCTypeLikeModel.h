//
//  JMCTypeLikeModel.h
//  JMian
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCTypeLikeModel : NSObject

@property (nonatomic, copy) NSString *favorite_id;

@property (nonatomic, copy) NSString *work_salary_min;
@property (nonatomic, copy) NSString *work_salary_max;
@property (nonatomic, copy) NSString *work_description;
@property (nonatomic, copy) NSString *work_user_id;

@property (nonatomic, copy) NSString *work_work_name;
@property (nonatomic, copy) NSString *work_address;
@property (nonatomic, copy) NSString *work_company_logo_path;
@property (nonatomic, copy) NSString *work_company_company_name;

@property (nonatomic, copy) NSString *user_user_id;
@property (nonatomic, copy) NSString *user_email;
@property (nonatomic, copy) NSString *user_phone;
@property (nonatomic, copy) NSString *user_nickname;
@property (nonatomic, copy) NSString *user_avatar;
@property (nonatomic, copy) NSString *foreign_key;

@end

NS_ASSUME_NONNULL_END
