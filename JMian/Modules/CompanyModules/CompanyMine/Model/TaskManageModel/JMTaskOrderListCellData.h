//
//  JMTaskOrderListCellData.h
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMTaskOrderListCellData : NSObject
@property (nonatomic, copy) NSString *task_order_id;
@property (nonatomic, copy) NSString *task_title;
@property (nonatomic, copy) NSString *task_id;

@property (nonatomic, copy) NSString *payment_money;
@property (nonatomic, copy) NSString *front_money;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *payment_method;
@property (nonatomic, strong) NSArray *industry;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *denial_reason;
@property (nonatomic, copy) NSString *is_comment_boss;
@property (nonatomic, copy) NSString *is_comment_user;


@property (nonatomic, copy) NSString *snapshot_task_id;
@property (nonatomic, copy) NSString *snapshot_type_label_id;
@property (nonatomic, copy) NSString *snapshot_user_id;
@property (nonatomic, copy) NSString *snapshot_task_title;
@property (nonatomic, copy) NSString *snapshot_payment_method;
@property (nonatomic, copy) NSString *snapshot_unit;
@property (nonatomic, copy) NSString *snapshot_payment_money;
@property (nonatomic, copy) NSString *snapshot_front_money;
@property (nonatomic, copy) NSString *snapshot_quantity_max;
@property (nonatomic, copy) NSString *snapshot_deadline;
@property (nonatomic, copy) NSString *snapshot_description;
@property (nonatomic, copy) NSString *snapshot_address;
@property (nonatomic, copy) NSString *snapshot_longitude;
@property (nonatomic, copy) NSString *snapshot_latitude;
@property (nonatomic, copy) NSString *snapshot_status;
@property (nonatomic, copy) NSString *snapshot_cityId;
@property (nonatomic, copy) NSString *snapshot_cityName;
@property (nonatomic, copy) NSString *snapshot_companyID;
@property (nonatomic, copy) NSString *snapshot_companyName;
@property (nonatomic, copy) NSString *snapshot_companyLogo_path;
@property (nonatomic, copy) NSString *snapshot_reputation;
@property (nonatomic, copy) NSString *snapshot_user_nickname;
@property (nonatomic, copy) NSString *snapshot_user_avatar;




@property (nonatomic, copy) NSString *user_user_id;
@property (nonatomic, copy) NSString *user_company_id;
@property (nonatomic, copy) NSString *user_nickname;
@property (nonatomic, copy) NSString *user_avatar;



@property (nonatomic, copy) NSString *boss_user_id;
@property (nonatomic, copy) NSString *boss_company_id;
@property (nonatomic, copy) NSString *boss_nickname;
@property (nonatomic, copy) NSString *boss_avatar;


//@property (nonatomic, copy) NSString *companyID;
//@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *goodsTitle;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsDescription;




@end
@interface JMTaskOrderIndustryModel : NSObject
@property (nonatomic, copy) NSString *label_id;
@property (nonatomic, copy) NSString *name;


@end

NS_ASSUME_NONNULL_END
