//
//  JMTaskPartTimejobDetailModel.h
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMTaskPartTimejobDetailModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *task_id;

@property (nonatomic, copy) NSString *task_title;
@property (nonatomic, copy) NSString *payment_method;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *payment_money;
@property (nonatomic, copy) NSString *front_money;
@property (nonatomic, copy) NSString *quantity_max;
@property (nonatomic, copy) NSString *deadline;
@property (nonatomic, copy) NSString *taskDescription;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *user_user_id;
@property (nonatomic, copy) NSString *user_company_id;
@property (nonatomic, copy) NSString *user_nickname;
@property (nonatomic, copy) NSString *user_avatar;

@property (nonatomic, copy) NSString *cityID;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *type_labelID;
@property (nonatomic, copy) NSString *type_labelName;

@property (nonatomic, copy) NSString *companyID;
@property (nonatomic, copy) NSString *companyName;



@property (nonatomic, copy) NSString *video_file_id;
@property (nonatomic, copy) NSString *video_type;
@property (nonatomic, copy) NSString *video_cover;
@property (nonatomic, copy) NSString *video_file_path;
@property (nonatomic, copy) NSString *video_status;
@property (nonatomic, copy) NSString *video_denial_reason;


@property (nonatomic, copy) NSString *goodsTitle;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsDescription;

@property (nonatomic, copy) NSString *invoice_email;
@property (nonatomic, copy) NSString *invoice_title;
@property (nonatomic, copy) NSString *invoice_tax_number;

@property (nonatomic, strong) NSArray *industry;
@property (nonatomic, strong) NSArray *images;




@end

@interface JMTaskIndustryModel : NSObject
@property (nonatomic, copy) NSString *label_id;
@property (nonatomic, copy) NSString *name;


@end

NS_ASSUME_NONNULL_END
