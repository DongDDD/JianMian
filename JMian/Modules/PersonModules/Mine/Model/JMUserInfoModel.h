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
@property (nonatomic, copy) NSString *deadline;
@property (nonatomic, copy) NSString *ability_count;
@property (nonatomic, copy) NSString *sdkAppid;

@property (nonatomic, assign) BOOL isNewUser;

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
@property (nonatomic, copy) NSString *company_real_company_name;
@property (nonatomic, copy) NSString *company_real_business_scope;
@property (nonatomic, copy) NSString *company_real_reg_date;
@property (nonatomic, copy) NSString *company_real_denial_reason;
@property (nonatomic, copy) NSString *company_real_unified_credit_code;
@property (nonatomic, copy) NSString *company_real_license_path;
@property (nonatomic, copy) NSString *company_real_status;
@property (nonatomic, copy) NSString *company_real_reg_capital;

@property (nonatomic, copy) NSString *share;
// 累计收入
@property (nonatomic, copy) NSString *available_amount_c;
@property (nonatomic, copy) NSString *unusable_amount_c;
@property (nonatomic, copy) NSString *available_amount_b;
@property (nonatomic, copy) NSString *unusable_amount_b;
@property (nonatomic, copy) NSString *task_completed_count;
@property (nonatomic, copy) NSString *task_processing_count;
//店铺
@property (nonatomic, copy) NSString *shop_address;
@property (nonatomic, copy) NSString *shop_description;
@property (nonatomic, copy) NSString *shop_logo;
@property (nonatomic, copy) NSString *shop_name;
@property (nonatomic, copy) NSString *shop_business_hours_start;
@property (nonatomic, copy) NSString *shop_poster;
@property (nonatomic, copy) NSString *shop_phone;
@property (nonatomic, copy) NSString *shop_business_hours_end;
@property (nonatomic, copy) NSString *shop_area_id;
@property (nonatomic, copy) NSString *shop_sort;
@property (nonatomic, copy) NSString *shop_status;
@property (nonatomic, copy) NSString *shop_shop_id;







@end
//"shop_address" : "",
// "description" : null,
// "shop_logo" : "",
// "shop_name" : "魔兽专卖店",
// "business_hours_start" : null,
// "created_at" : "2020-01-10 09:27:31",
// "shop_poster" : "魔兽专卖",
// "shop_phone" : "16626407541",
// "business_hours_end" : null,
// "area_id" : 0,
// "sort" : 50,
// "status" : 0,
// "shop_id" : 2

NS_ASSUME_NONNULL_END
