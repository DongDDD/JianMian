//
//  JMHTTPManager+FectchOrderInfo.m
//  JMian
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+FectchOrderInfo.h"

@implementation JMHTTPManager (FectchOrderInfo)
- (void)fectchOrderInfoWithOrder_id:(nullable NSString *)order_id
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Fectch_OrderInfo_URL stringByAppendingFormat:@"/%@",order_id];

    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
