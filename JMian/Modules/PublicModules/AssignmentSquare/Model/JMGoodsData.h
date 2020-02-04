//
//  JMGoodsData.h
//  JMian
//
//  Created by mac on 2020/1/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMGoodsData : NSObject
@property (copy, nonatomic) NSString *is_sku;
@property (copy, nonatomic) NSString *goods_description;
@property (copy, nonatomic) NSString *video_file_path;
@property (copy, nonatomic) NSString *video_file_id;
@property (copy, nonatomic) NSString *video_cover_path;

@property (copy, nonatomic) NSString *goods_no;
@property (copy, nonatomic) NSString *salary;
@property (copy, nonatomic) NSString *sort_id;
@property (copy, nonatomic) NSString *quantity_sold;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *inventory;
@property (copy, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSArray *images;


@end
@interface JMGoodsImageData : NSObject

 @property (copy, nonatomic) NSString *file_id;
 @property (copy, nonatomic) NSString *file_path;


@end
NS_ASSUME_NONNULL_END
