//
//  JMHTTPManager+OrderPay.m
//  JMian
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+OrderPay.h"

@implementation JMHTTPManager (OrderPay)

- (void)fectchOrderPaymentInfoWithOrder_id:(NSString *)order_id
                                    scenes:(NSString *)scenes
                                      type:(NSString *)type
                                      mode:(NSString *)mode
                                is_invoice:(NSString *)is_invoice
                         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSDictionary *dic =  @{
                           @"order_id":order_id,
                           @"scenes":scenes,
                           @"type":type,
                           @"mode":mode,
                           @"is_invoice":is_invoice,

                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Fectch_OrderPayment_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
