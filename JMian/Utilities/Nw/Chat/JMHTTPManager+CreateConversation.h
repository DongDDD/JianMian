//
//  JMHTTPManager+CreateConversation.h
//  JMian
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CreateConversation)

- (void)createChat_type:(NSString *)type
              recipient:(NSString *)recipient
            foreign_key:(NSString *)foreign_key
            sender_mark:(NSString *)sender_mark
         recipient_mark:(NSString *)recipient_mark

           successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)createFriendChatWithType:(NSString *)type
        account:(NSString *)account
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
