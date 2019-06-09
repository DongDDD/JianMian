//
//  JMHTTPManager+UpdateTask.h
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (UpdateTask)
- (void)updateTaskWithId:(nullable NSString *)Id
          payment_method:(nullable NSMutableArray *)payment_method
                    unit:(nullable NSString *)unit
           payment_money:(nullable NSString *)payment_money
             front_money:(nullable NSString *)front_money
            quantity_max:(nullable NSArray *)quantity_max
           myDescription:(nullable NSString *)myDescription
            industry_arr:(nullable NSMutableArray *)industry_arr
                 city_id:(nullable NSString *)city_id
               longitude:(nullable NSString *)longitude
                latitude:(nullable NSString *)latitude
                 address:(nullable NSArray *)address
             goods_title:(nullable NSString *)goods_title
             goods_price:(nullable NSMutableArray *)goods_price
              goods_desc:(nullable NSString *)goods_desc
              video_path:(nullable NSString *)video_path
             video_cover:(nullable NSString *)video_cover
               image_arr:(nullable NSArray *)image_arr
                  status:(nullable NSString *)status
            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
