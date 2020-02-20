//
//  JMShopInfoModel.h
//  JMian
//
//  Created by mac on 2020/2/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//"shop_address" : "",
//"description" : "afsdfasdfasdf",
//"shop_logo" : "",
//"shop_name" : "测试小店3",
//"business_hours_start" : null,
//"created_at" : "2020-01-31 12:25:42",
//"shop_poster" : "",
//"shop_phone" : "",
//"user_id" : 1,
//"business_hours_end" : null,
//"area_id" : 0,
//"sort" : 50,
//"status" : 1,
//"shop_id" : 4
@interface JMShopInfoModel : NSObject
@property(nonatomic,copy)NSString *shop_address;
@property(nonatomic,copy)NSString *shop_description;
@property(nonatomic,copy)NSString *shop_logo;
@property(nonatomic,copy)NSString *shop_name;
@property(nonatomic,copy)NSString *business_hours_start;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *shop_poster;
@property(nonatomic,copy)NSString *shop_phone;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *business_hours_end;
@property(nonatomic,copy)NSString *area_id;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *shop_id;
@property(nonatomic,copy)NSString *all_total;
@property(nonatomic,copy)NSString *dfh_total;
@property(nonatomic,copy)NSString *shz_total;
@property(nonatomic,copy)NSString *wfk_total;

@end

NS_ASSUME_NONNULL_END
