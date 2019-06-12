//
//  JMHTTPManager+FectchMyTaskOrderList.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchMyTaskOrderList.h"

@implementation JMHTTPManager (FectchMyTaskOrderList)

- (void)fectchTaskList_status:(nullable NSArray *)status
                          page:(nullable NSString *)page
                      per_page:(nullable NSString *)per_page
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"status":status,
                           @"page":page,
                           @"per_page":per_page
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_TaskOrderList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
