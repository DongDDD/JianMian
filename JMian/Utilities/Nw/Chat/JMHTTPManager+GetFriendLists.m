//
//  JMHTTPManager+GetFriendLists.m
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+GetFriendLists.h"


@implementation JMHTTPManager (GetFriendLists)

- (void)getFriendListWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_FriendList_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
