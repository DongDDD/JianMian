//
//  JMHTTPManager+CreateConversation.m
//  JMian
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CreateConversation.h"

@implementation JMHTTPManager (CreateConversation)

- (void)createChat_type:(NSString *)type
              recipient:(NSString *)recipient
            foreign_key:(NSString *)foreign_key
            sender_mark:(NSString *)sender_mark
            recipient_mark:(NSString *)recipient_mark

                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"type":type,
                           @"recipient":recipient,
                           @"foreign_key":foreign_key,
                           @"sender_mark":sender_mark,
                           @"recipient_mark":recipient_mark

                           
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Chat_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)createFriendChatWithType:(NSString *)type
                         account:(NSString *)account

                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"type":type,
                           @"account":account,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Chat_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
