//
//  JMHTTPManager+ApplePayNotify.m
//  JMian
//
//  Created by mac on 2019/9/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+ApplePayNotify.h"

@implementation JMHTTPManager (ApplePayNotify)
- (void)fetchAppllePayNotifyWithReceipt_data:(nullable NSString *)receipt_data
                                total_amount:(nullable NSString *)total_amount
                                out_trade_no:(nullable NSString *)out_trade_no
                                SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =     @{
                              @"receipt_data":receipt_data,
                              @"total_amount":total_amount,
                              @"out_trade_no":out_trade_no,
                              };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:ApplyPay_Notify_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

@end
