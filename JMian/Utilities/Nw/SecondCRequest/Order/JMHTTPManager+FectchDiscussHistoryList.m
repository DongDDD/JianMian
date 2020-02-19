//
//  JMHTTPManager+FectchDiscussHistoryList.m
//  JMian
//
//  Created by mac on 2020/2/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+FectchDiscussHistoryList.h"

 

@implementation JMHTTPManager (FectchDiscussHistoryList)
- (void)fectchDiscussListWithOrder_id:(nullable NSString *)order_id
                         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSDictionary *dic =  @{
        @"order_id":order_id,
    };
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_DiscussList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
