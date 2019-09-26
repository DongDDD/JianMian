//
//  JMHTTPManager+UnReadNotice.h
//  JMian
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (UnReadNotice)
- (void)unreadNoticeCardWithUser_id:(NSString *)user_id
                            message:(NSString *)message
                       successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
