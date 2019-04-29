//
//  JMHTTPManager+MessageList.h
//  JMian
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//


#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (MessageList)

- (void)fecthMessageList_mode:(NSString *)mode
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


@end

NS_ASSUME_NONNULL_END
