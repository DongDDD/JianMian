//
//  JMOrderInfoModel.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMOrderInfoModel : NSObject
@property (nonatomic, copy) NSString *after_sale_record_id;
@property (nonatomic, copy) NSString *after_sale_message;
@property (nonatomic, copy) NSString *after_sale_user_id;
@property (nonatomic, copy) NSString *after_sale_boss_id;
@property (nonatomic, copy) NSString *after_sale_created_at;
@property (nonatomic, copy) NSString *contact_address;
@property (nonatomic, copy) NSString *contact_phone;
@property (nonatomic, copy) NSString *contact_name;
@property (nonatomic, copy) NSString *order_no;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *logistics_at;
@property (nonatomic, copy) NSString *order_amount;
@property (nonatomic, copy) NSString *pay_amount;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *pay_time;
@property (nonatomic, copy) NSString *logistics_at_c;
@property (nonatomic, copy) NSString *logistics_name;

 

@property (nonatomic, copy) NSArray *goods;
@end

@interface JMGoodsCellData : NSObject
@property (nonatomic, copy) NSString *cover_path;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
