//
//  JMOrderCellData.h
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface JMOrderCellData : NSObject

@property(nonatomic,assign)BOOL isSpread;


@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *contact_name;
@property (nonatomic, copy) NSString *contact_phone;
@property (nonatomic, copy) NSString *contact_address;
@property (nonatomic, copy) NSString *industry_label_id;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *buy_quantity;
@property (nonatomic, copy) NSString *order_amount;
@property (nonatomic, copy) NSString *pay_amount;
@property (nonatomic, copy) NSString *pay_time;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *logistics_name;
@property (nonatomic, copy) NSString *logistics_label_id;
@property (nonatomic, copy) NSString *logistics_no;

//-----快照----
@property (nonatomic, copy) NSString *snapshot_task_id;

@property (nonatomic, copy) NSString *snapshot_company_company_id;
@property (nonatomic, copy) NSString *snapshot_company_company_name;
@property (nonatomic, copy) NSString *snapshot_company_logo_path;
@property (nonatomic, copy) NSString *snapshot_company_reputation;

@property (nonatomic, copy) NSString *snapshot_goods_goods_title;
@property (nonatomic, copy) NSString *snapshot_goods_goods_price;
@property (nonatomic, copy) NSString *snapshot_goods_description;

@property (nonatomic, copy) NSString *snapshot_video_file_id;
@property (nonatomic, copy) NSString *snapshot_video_type;
@property (nonatomic, copy) NSString *snapshot_video_cover;
@property (nonatomic, copy) NSString *snapshot_video_file_path;
@property (nonatomic, copy) NSString *snapshot_video_status;
@property (nonatomic, copy) NSString *snapshot_video_denial_reason;
@property (nonatomic, copy) NSString *snapshot_video_look;

@property (nonatomic, strong) NSArray *snapshot_images;
//----------
@property (nonatomic, copy) NSString *referrer_user_id;
@property (nonatomic, copy) NSString *referrer_phone;
@property (nonatomic, copy) NSString *referrer_nickname;
@property (nonatomic, copy) NSString *referrer_avatar;
@property (nonatomic, copy) NSString *referrer_reputation;

@property (nonatomic, copy) NSString *boss_reputation;
@property (nonatomic, copy) NSString *boss_user_id;
@property (nonatomic, copy) NSString *boss_nickname;
@property (nonatomic, copy) NSString *boss_company_id;
@property (nonatomic, copy) NSString *boss_avatar;


@property (nonatomic, copy) NSString *city_city_id;
@property (nonatomic, copy) NSString *city_city_name;
@property (nonatomic, strong) NSArray *city_name_relation;

@property (nonatomic, copy) NSString *company_company_id;
@property (nonatomic, copy) NSString *company_company_name;
@property (nonatomic, copy) NSString *company_logo_path;
@property (nonatomic, copy) NSString *company_reputation;

@property (nonatomic, copy) NSString *shop_shop_name;
@property (nonatomic, copy) NSString *shop_user_id;
@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *after_sale_record_id;
@property (nonatomic, copy) NSString *after_sale_message;
@property (nonatomic, copy) NSString *after_sale_user_id;
@property (nonatomic, copy) NSString *after_sale_boss_id;
@property (nonatomic, copy) NSString *after_sale_created_at;
@property (nonatomic, copy) NSArray *goods;

@end
@interface JMSnapshotImageModel : NSObject

@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *denial_reason;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *file_id;
@property (copy, nonatomic) NSString *file_path;

@end

@interface JMGoodsInfoCellData : NSObject
@property (nonatomic, copy) NSString *cover_path;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
