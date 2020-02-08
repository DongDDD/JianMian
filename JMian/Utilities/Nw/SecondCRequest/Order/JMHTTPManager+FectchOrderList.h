//
//  JMHTTPManager+FectchOrderList.h
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchOrderList)
- (void)fectchOrderList_order_id:(nullable NSArray *)order_id
                    contact_city:(nullable NSString *)contact_city
                   contact_phone:(nullable NSString *)contact_phone
                         keyword:(nullable NSString *)keyword
                          status:(nullable NSString *)status
                          s_date:(nullable NSString *)s_date
                          e_date:(nullable NSString *)e_date
                            page:(nullable NSString *)page
                        per_page:(nullable NSString *)per_page
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)changeOrderStatusWithOrder_id:(NSString *)order_id
                status:(NSString *)status
                         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
