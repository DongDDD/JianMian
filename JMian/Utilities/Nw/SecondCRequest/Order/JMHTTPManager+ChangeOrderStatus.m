//
//  JMHTTPManager+ChangeOrderStatus.m
//  JMian
//
//  Created by mac on 2020/2/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+ChangeOrderStatus.h"
@implementation JMHTTPManager (ChangeOrderStatus)

- (void)changeOrderStatusWithOrder_id:(NSString *)order_id
                                  status:(NSString *)status
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Change_OrderStatus_URL stringByAppendingFormat:@"/%@",order_id];
    
    NSDictionary *dic =  @{
                           @"status":status
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
