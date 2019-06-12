//
//  JMHTTPManager+TaskOrderStatus.m
//  JMian
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+TaskOrderStatus.h"

@implementation JMHTTPManager (TaskOrderStatus)

- (void)changeTaskOrderStatusWithTask_order_id:(NSString *)task_order_id
                                  status:(NSString *)status
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Change_TaskOrderStatus_URL stringByAppendingFormat:@"/%@",task_order_id];
    
    NSDictionary *dic =  @{
                           @"status":status
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
