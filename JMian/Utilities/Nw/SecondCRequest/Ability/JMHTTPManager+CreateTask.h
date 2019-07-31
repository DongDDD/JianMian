//
//  JMHTTPManager+CreateTask.h
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CreateTask)
- (void)createTask_task_title:(nullable NSString *)task_title
                type_label_id:(nullable NSString *)type_label_id
               payment_method:(nullable NSString *)payment_method
                         unit:(nullable NSString *)unit
                payment_money:(nullable NSString *)payment_money
                  front_money:(nullable NSString *)front_money
                 quantity_max:(nullable NSString *)quantity_max
                myDescription:(nullable NSString *)myDescription
                 industry_arr:(nullable NSMutableArray *)industry_arr
                      city_id:(nullable NSString *)city_id
                    longitude:(nullable NSString *)longitude
                     latitude:(nullable NSString *)latitude
                      address:(nullable NSString *)address
                  goods_title:(nullable NSString *)goods_title
                  goods_price:(nullable NSString *)goods_price
                   goods_desc:(nullable NSString *)goods_desc
                   video_path:(nullable NSString *)video_path
                  video_cover:(nullable NSString *)video_cover
                    image_arr:(nullable NSArray *)image_arr
                     deadline:(nullable NSString *)deadline
                       status:(nullable NSString *)status
                   is_invoice:(nullable NSString *)is_invoice
                invoice_title:(nullable NSString *)invoice_title
           invoice_tax_number:(nullable NSString *)invoice_tax_number
                invoice_email:(nullable NSString *)invoice_email

                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
