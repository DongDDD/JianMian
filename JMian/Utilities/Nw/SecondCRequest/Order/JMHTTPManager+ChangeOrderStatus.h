//
//  JMHTTPManager+ChangeOrderStatus.h
//  JMian
//
//  Created by mac on 2020/2/6.
//  Copyright © 2020 mac. All rights reserved.
//


#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (ChangeOrderStatus)
- (void)changeOrderStatusWithOrder_id:(NSString *)order_id
                               status:(NSString *)status
                         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
- (void)deliverGoodsWithOrder_id:(NSString *)order_id
                          status:(NSString *)status
                    logistics_no:(NSString *)logistics_no
                    logistics_id:(NSString *)logistics_id
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
