//
//  JMHTTPManager+DeleteFriend.h
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (DeleteFriend)
- (void)deleteFriendWithId:(NSString *)Id
              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBloc;
@end

NS_ASSUME_NONNULL_END
