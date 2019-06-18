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
@property (nonatomic, copy) NSString *company_position;
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

@property (nonatomic, copy) NSString *card_status;
@property (nonatomic, copy) NSString *card_sex;
@property (nonatomic, copy) NSString *card_ethnic;
@property (nonatomic, copy) NSString *card_name;
@property (nonatomic, copy) NSString *card_birthday;
@property (nonatomic, copy) NSString *card_denial_reason;

@property (nonatomic, copy) NSString *company_real_reg_address;
@property (nonatomic, copy) NSString *company_real_company_position;
@property (nonatomic, copy) NSString *company_real_company_real_id;
@property (nonatomic, copy) NSString *company_real_company_id;
@property (nonatomic, copy) NSString *company_real_corporate;
@property (nonatomic, copy) NSString *company_user_id;
@property (nonatomic, copy) NSString *company_company_name;
@property (nonatomic, copy) NSString *company_business_scope;
@property (nonatomic, copy) NSString *company_reg_date;
@property (nonatomic, copy) NSString *company_denial_reason;
@property (nonatomic, copy) NSString *company_unified_credit_code;
@property (nonatomic, copy) NSString *company_license_path;
@property (nonatomic, copy) NSString *company_status;
@property (nonatomic, copy) NSString *company_reg_capital;

@property (nonatomic, copy) NSString *share;
// 累计收入
@property (nonatomic, copy) NSString *available_amount_c;
@property (nonatomic, copy) NSString *unusable_amount_c;
@property (nonatomic, copy) NSString *available_amount_b;
@property (nonatomic, copy) NSString *unusable_amount_b;
@property (nonatomic, copy) NSString *task_completed_count;
@property (nonatomic, copy) NSString *task_processing_count;


@end


NS_ASSUME_NONNULL_END
