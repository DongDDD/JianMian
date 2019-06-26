//
//  JMCDetailModel.h
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCDetailModel : NSObject
@property(nonatomic, copy)NSString *share_url;
@property(nonatomic, strong)NSArray *images;
@property(nonatomic, copy)NSString *task_title;
@property(nonatomic, copy)NSString *company_company_name;
@property(nonatomic, copy)NSString *company_logo_path;
@property(nonatomic, copy)NSString *myDescription;


@property(nonatomic, copy)NSString *goods_description;
@property(nonatomic, copy)NSString *goods_goods_title;
@property(nonatomic, copy)NSString *goods_goods_price;
@property(nonatomic, copy)NSString *payment_money;

@end


@interface JMCDetailImageModel : NSObject

@property(nonatomic, copy)NSString *file_path;

@end
NS_ASSUME_NONNULL_END
