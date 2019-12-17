//
//  JMHTTPManager+AddFriend.m
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+AddFriend.h"


@implementation JMHTTPManager (AddFriend)

- (void)addFriendtWithRelation_id:(NSString *)relation_id
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"relation_id":relation_id,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Add_Friend_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)searchFriendtWithPhone:(NSString *)phone
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"phone":phone,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Search_Friend_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
