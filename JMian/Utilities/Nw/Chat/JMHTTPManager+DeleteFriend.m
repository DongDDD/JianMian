//
//  JMHTTPManager+DeleteFriend.m
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+DeleteFriend.h"

@implementation JMHTTPManager (DeleteFriend)

- (void)deleteFriendWithId:(NSString *)Id
            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Delete_Friend_URL stringByAppendingFormat:@"/%@",Id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
