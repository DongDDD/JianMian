//
//  JMHTTPManager+DeleteWork.h
//  JMian
//
//  Created by mac on 2019/9/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (DeleteWork)

- (void)deleteWorkWithId:(NSString *)Id
            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
