//
//  JMHTTPManager+FectchDiscussHistoryList.h
//  JMian
//
//  Created by mac on 2020/2/18.
//  Copyright © 2020 mac. All rights reserved.
//

 

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchDiscussHistoryList)
- (void)fectchDiscussListWithOrder_id:(nullable NSString *)order_id
                       successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
