//
//  JMHTTPManager+UnReadNotice.m
//  JMian
//
//  Created by mac on 2019/9/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+UnReadNotice.h"

@implementation JMHTTPManager (UnReadNotice)

- (void)unreadNoticeCardWithUser_id:(NSString *)user_id
                       message:(NSString *)message
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"user_id":user_id,
                           @"message":message,
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Unread_Notice_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
