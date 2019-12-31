//
//  JMHTTPManager+GetProfileInfo.m
//  JMian
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+GetProfileInfo.h"

@implementation JMHTTPManager (GetProfileInfo)

- (void)getBUserProfileWithUser_id:(NSString *)user_id successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSDictionary *dic =  @{@"user_id":user_id};

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:User_info_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)getBUserProfileTaskListWithUser_id:(NSString *)user_id
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
     NSDictionary *dic =  @{@"user_id":user_id};

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_TaskList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)getCUserProfileWithUser_id:(nullable NSString *)user_id
                        SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSDictionary *dic =  @{@"user_id":user_id};

    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Vita_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)getCUserProfileAbilityListWithUser_id:(nullable NSString *)user_id
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"user_id":user_id,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_Ability_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}



@end
