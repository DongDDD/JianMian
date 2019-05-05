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
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"type":type,@"recipient":recipient,@"foreign_key":foreign_key};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Chat_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
