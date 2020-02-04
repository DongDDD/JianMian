//
//  JMShopModel.h
//  JMian
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMShopModel : NSObject
@property (copy, nonatomic) NSString *shop_address;
@property (copy, nonatomic) NSString *shop_description;
@property (copy, nonatomic) NSString *shop_logo;
@property (copy, nonatomic) NSString *shop_name;
@property (copy, nonatomic) NSString *business_hours_start;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *shop_poster;
@property (copy, nonatomic) NSString *shop_phone;
@property (copy, nonatomic) NSString *business_hours_end;
@property (copy, nonatomic) NSString *area_id;
@property (copy, nonatomic) NSString *sort;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *shop_id;

@end

NS_ASSUME_NONNULL_END
