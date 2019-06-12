//
//  JMHTTPManager+CreateTaskComment.m
//  JMian
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CreateTaskComment.h"

@implementation JMHTTPManager (CreateTaskComment)

- (void)createTaskCommentWithForeign_key:(NSString *)foreign_key
                                        reputation:(NSString *)reputation
                                  commentDescription:(NSString *)commentDescription

                                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"foreign_key":foreign_key,
                           @"reputation":reputation,
                           @"description":commentDescription,
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_TaskComment_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
