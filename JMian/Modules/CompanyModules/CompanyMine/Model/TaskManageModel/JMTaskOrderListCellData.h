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

@property (nonatomic, copy) NSString *snapshot_change;


@property (nonatomic, copy) NSString *user_user_id;
@property (nonatomic, copy) NSString *user_company_id;
@property (nonatomic, copy) NSString *user_nickname;
@property (nonatomic, copy) NSString *user_avatar;


@property (nonatomic, copy) NSString *boss_user_id;
@property (nonatomic, copy) NSString *boss_company_id;
@property (nonatomic, copy) NSString *boss_nickname;
@property (nonatomic, copy) NSString *boss_avatar;


@property (nonatomic, copy) NSString *companyID;
@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *goodsTitle;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsDescription;




@end
@interface JMTaskOrderIndustryModel : NSObject
@property (nonatomic, copy) NSString *label_id;
@property (nonatomic, copy) NSString *name;


@end

NS_ASSUME_NONNULL_END
