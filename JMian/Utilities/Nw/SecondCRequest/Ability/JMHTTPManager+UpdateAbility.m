//
//  JMHTTPManager+UpdateAbility.m
//  JMian
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+UpdateAbility.h"

@implementation JMHTTPManager (UpdateAbility)

- (void)updateAbility_Id:(nullable NSString *)Id
                 city_id:(nullable NSString *)city_id
           type_label_id:(nullable NSString *)type_label_id
            industry_arr:(nullable NSMutableArray *)industry_arr
           myDescription:(nullable NSString *)myDescription
              video_path:(nullable NSString *)video_path
             video_cover:(nullable NSString *)video_cover
               image_arr:(nullable NSArray *)image_arr
                  status:(nullable NSString *)status
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Update_Ability_URL stringByAppendingFormat:@"/%@",Id];

    NSDictionary *dic =  @{@"city_id":city_id,
                           @"type_label_id":type_label_id,
                           @"industry_arr":industry_arr,
                           @"description":myDescription,
                           @"video_path":video_path,
                           @"video_cover":video_cover,
                           @"image_arr":image_arr,
                           @"status":status
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
