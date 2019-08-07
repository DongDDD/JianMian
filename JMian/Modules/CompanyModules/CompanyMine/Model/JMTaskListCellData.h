//
//  JMTaskListCellData.h
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMTaskListCellData : NSObject

@property (nonatomic, copy) NSString *task_id;

@property (nonatomic, copy) NSString *task_title;
@property (nonatomic, copy) NSString *payment_method;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *payment_money;
@property (nonatomic, copy) NSString *front_money;
@property (nonatomic, copy) NSString *quantity_max;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *type_labelID;
@property (nonatomic, copy) NSString *type_labelName;

@property (nonatomic, copy) NSString *companyiId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *companyLogo_path;
@property (nonatomic, copy) NSString *companyReputation;

@property (nonatomic, copy) NSString *cityID;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *goodsTitle;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsDescription;



@end

NS_ASSUME_NONNULL_END
