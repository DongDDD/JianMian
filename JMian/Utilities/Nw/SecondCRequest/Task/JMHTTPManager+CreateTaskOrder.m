//
//  JMHTTPManager+CreateTaskOrder.m
//  JMian
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CreateTaskOrder.h"

@implementation JMHTTPManager (CreateTaskOrder)
- (void)createTaskOrder_taskID:(NSString *)taskID
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
 
    NSDictionary *dic =  @{
                           @"task_id":taskID
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_TaskOrder_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
