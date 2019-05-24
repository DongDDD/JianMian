//
//  JMHTTPManager+InterView.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+InterView.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (InterView)

- (void)fetchInterViewListWithStatus:(NSArray *)status
                            page:(NSString *)page
                        per_page:(NSString *)per_page

                   successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock{
    
    NSDictionary *dic = @{@"status":status,@"page":page,@"per_page":per_page};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:List_Interview_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)createInterViewWith_user_job_id:(NSString *)user_job_id
                                time:(NSString *)time

                        successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock{
    
    NSDictionary *dic = @{@"user_job_id":user_job_id,@"time":time};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Interview_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)updateInterViewWith_Id:(NSString *)Id
                        status:(NSString *)status

                           successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock{
    
    NSString *urlStr = [Update_Interview_URL stringByAppendingFormat:@"/%@",Id];
    NSDictionary *dic = @{@"status":status};

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)feedbackInterViewWith_interview_id:(NSString *)interview_id
                        label_ids:(NSArray *)label_ids
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock{
    
    NSDictionary *dic = @{@"interview_id":interview_id,@"label_ids":label_ids};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Feedback_Interview_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}



@end
