//
//  JMHTTPManager+ApplePayNotify.h
//  JMian
//
//  Created by mac on 2019/9/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (ApplePayNotify)
- (void)fetchAppllePayNotifyWithReceipt_data:(nullable NSString *)receipt_data
                                total_amount:(nullable NSString *)total_amount
                                out_trade_no:(nullable NSString *)out_trade_no
                                SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
