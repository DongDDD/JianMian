//
//  JMHTTPManager+OrderPay.h
//  JMian
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mac. All rights reserved.
//


#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (OrderPay)
- (void)fectchOrderPaymentInfoWithOrder_id:(NSString *)order_id
                                    scenes:(NSString *)scenes
                                      type:(NSString *)type
                                      mode:(NSString *)mode
                                is_invoice:(NSString *)is_invoice
                              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
