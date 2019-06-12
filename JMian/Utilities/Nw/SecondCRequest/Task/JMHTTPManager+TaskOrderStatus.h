//
//  JMHTTPManager+TaskOrderStatus.h
//  JMian
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (TaskOrderStatus)

- (void)changeTaskOrderStatusWithTask_order_id:(NSString *)task_order_id
                                        status:(NSString *)status
                                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
