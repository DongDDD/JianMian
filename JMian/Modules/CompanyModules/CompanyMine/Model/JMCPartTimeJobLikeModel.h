//
//  JMCPartTimeJobLikeModel.h
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCPartTimeJobLikeModel : NSObject

@property (nonatomic, copy) NSString *task_type_label_name;
@property (nonatomic, copy) NSString *task_typeLabel_id;
@property (nonatomic, copy) NSString *task_description;
@property (nonatomic, copy) NSString *task_ability_id;
@property (nonatomic, copy) NSString *task_unit;

@property (nonatomic, strong) NSArray *task_industry;

@property (nonatomic, copy) NSString *task_payment_method;
@property (nonatomic, copy) NSString *task_quantity_max;
@property (nonatomic, copy) NSString *task_task_title;
@property (nonatomic, copy) NSString *task_front_money;

@property (nonatomic, copy) NSString *company_company_name;
@property (nonatomic, copy) NSString *company_logo_path;
@property (nonatomic, copy) NSString *company_company_id;
@property (nonatomic, copy) NSString *company_reputation;

@property (nonatomic, copy) NSString *task_id;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city_city_id;
@property (nonatomic, copy) NSString *city_city_name;
@property (nonatomic, copy) NSString *task_payment_money;
@property (nonatomic, copy) NSString *task_deadline;
@property (nonatomic, copy) NSString *task_status;


@property (nonatomic, copy) NSString *task_user_reputation;
@property (nonatomic, copy) NSString *task_user_user_id;
@property (nonatomic, copy) NSString *task_user_nickname;
@property (nonatomic, copy) NSString *task_user_company_id;
@property (nonatomic, copy) NSString *task_user_avatar;

@property (nonatomic, copy) NSString *favorite_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *foreign_key;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *mode;


@end

@interface JMCLikeIndustryModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *label_id;

@end

NS_ASSUME_NONNULL_END
