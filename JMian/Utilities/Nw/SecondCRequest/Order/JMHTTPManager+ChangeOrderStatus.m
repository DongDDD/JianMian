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

- (void)deliverGoodsWithOrder_id:(NSString *)order_id
                          status:(NSString *)status
                    logistics_no:(NSString *)logistics_no
                    logistics_id:(NSString *)logistics_id
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Change_OrderStatus_URL stringByAppendingFormat:@"/%@",order_id];
    
    NSDictionary *dic =  @{
        @"status":status,
         @"logistics_no":logistics_no,
        @"logistics_id":logistics_id,
    };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
