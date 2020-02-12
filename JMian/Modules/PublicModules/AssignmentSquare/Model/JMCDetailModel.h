//
//  JMCDetailModel.h
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMGoodsData.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMCDetailModel : NSObject
@property(nonatomic, copy)NSString *favorites_id;


@property(nonatomic, copy)NSString *share_url;
@property(nonatomic, copy)NSString *task_title;
@property(nonatomic, copy)NSString *quantity_max;
@property(nonatomic, copy)NSString *effective_count;

@property(nonatomic, copy)NSString *company_company_name;
@property(nonatomic, copy)NSString *company_logo_path;
@property(nonatomic, copy)NSString *company_reputation;

@property(nonatomic, copy)NSString *myDescription;
@property(nonatomic, copy)NSString *type_label_name;
@property(nonatomic, copy)NSString *type_label_id;
@property(nonatomic, copy)NSString *status;
@property(nonatomic, copy)NSString *task_id;
@property(nonatomic, copy)NSString *user_id;
@property(nonatomic, copy)NSString *user_nickname;
@property(nonatomic, copy)NSString *user_company_id;
@property(nonatomic, copy)NSString *user_avatar;


@property(nonatomic, copy)NSString *goods_description;
@property(nonatomic, copy)NSString *goods_goods_title;
@property(nonatomic, copy)NSString *goods_goods_price;
@property(nonatomic, copy)NSString *payment_money;
@property(nonatomic, copy)NSString *front_money;
@property(nonatomic, copy)NSString *payment_method;

@property(nonatomic, copy)NSString *latitude;
@property(nonatomic, copy)NSString *longitude;
@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *city_id;
@property(nonatomic, copy)NSString *city_name;

@property(nonatomic, strong)NSArray *images;
@property(nonatomic, strong)NSArray *industry;
@property(nonatomic, strong)NSArray *goods;

@property(nonatomic, strong)NSString *video_file_path;
@property(nonatomic, strong)NSString *video_cover;

@end


@interface JMCDetailImageModel : NSObject

@property(nonatomic, copy)NSString *file_path;
@property(nonatomic, copy)NSString *status;

@end

//@interface JMCDetailVideoModel : NSObject
//
//@property(nonatomic, copy)NSString *file_path;
//@property(nonatomic, copy)NSString *cover;
//
//
//@end

@interface JMCDetailindustryModel : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *label_id;

@end
NS_ASSUME_NONNULL_END
