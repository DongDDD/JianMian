//
//  JMHTTPManager+FectchTaskList.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchTaskList.h"

@implementation JMHTTPManager (FectchTaskList)

- (void)fectchTaskList_user_id:(nullable NSString *)user_id
                          city_id:(nullable NSString *)city_id
                    type_label_id:(nullable NSString *)type_label_id
                     industry_arr:(nullable NSMutableArray *)industry_arr
//                        keyword:(nullable NSString *)keyword
                           status:(nullable NSString *)status
                             page:(nullable NSString *)page
                         per_page:(nullable NSString *)per_page
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"user_id":user_id,
                           @"city_id":city_id,
                           @"type_label_id":type_label_id,
                           @"industry_arr":industry_arr,
//                           @"keyword":keyword,
                           @"status":status,
                           @"page":page,
                           @"per_page":per_page
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_TaskList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
