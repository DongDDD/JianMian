//
//  JMHTTPManager+CreateTask.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CreateTask.h"

@implementation JMHTTPManager (CreateTask)

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
                      address:(nullable NSArray *)address
                  goods_title:(nullable NSString *)goods_title
                  goods_price:(nullable NSString *)goods_price
                   goods_desc:(nullable NSString *)goods_desc
                   video_path:(nullable NSString *)video_path
                  video_cover:(nullable NSString *)video_cover
                    image_arr:(nullable NSArray *)image_arr
                    deadline:(nullable NSString *)deadline
                       status:(nullable NSString *)status
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSDictionary *dic =  @{@"task_title":task_title,
                           @"type_label_id":type_label_id,
                           @"payment_method":payment_method,
                           @"unit":unit,
                           @"payment_money":payment_money,
                           @"front_money":front_money,
                           @"quantity_max":quantity_max,
                           @"description":myDescription,
                           @"industry_arr":industry_arr,
                           @"city_id":city_id,
                           @"longitude":longitude,
                           @"latitude":latitude,
                           @"address":address,
                           @"deadline":deadline,
                           @"goods_title":goods_title,
                           @"goods_price":goods_price,
                           @"goods_desc":goods_desc,
                           @"video_path":video_path,
                           @"video_cover":video_cover,
                           @"image_arr":image_arr,
                           @"status":status
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Task_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
