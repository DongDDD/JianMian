//
//  JMHTTPManager+CreateTaskOrder.h
//  JMian
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CreateTaskOrder)

- (void)createTaskOrder_taskID:(NSString *)taskID
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
