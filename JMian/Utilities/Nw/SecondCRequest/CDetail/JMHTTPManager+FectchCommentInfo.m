//
//  JMHTTPManager+FectchCommentInfo.m
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchCommentInfo.h"

@implementation JMHTTPManager (FectchCommentInfo)
- (void)fectchCommentInfoWithTask_order_id:(nullable NSString *)task_order_id
                                 order_id:(nullable NSString *)order_id
                                  user_id:(nullable NSString *)user_id
                               company_id:(nullable NSString *)company_id
                                     page:(nullable NSString *)page
                                 per_page:(nullable NSString *)per_page
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"task_order_id":task_order_id,
                           @"order_id":order_id,
                           @"user_id":user_id,
                           @"company_id":company_id,
                           @"page":page,
                           @"per_page":per_page,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_CommentList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
