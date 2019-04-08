//
//  JMHTTPManager+CreateExperience.m
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CreateExperience.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (CreateExperience)

- (void)createExperienceWithCompany_name:(NSString *)company_name job_label_id:(NSNumber *)job_label_id  start_date:(NSData *)start_date end_date:(nullable NSData *)end_date description:(NSString *)description successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    
    NSDictionary *dic = @{@"company_name":company_name,@"job_label_id":job_label_id,@"start_date":start_date,@"end_date":end_date,@"description":description};
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Experience_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)updateExperienceWith_experienceId:(NSNumber *)experienceId company_name:(nullable NSString *)company_name job_label_id:(nullable NSNumber *)job_label_id  start_date:(nullable NSData *)start_date end_date:(nullable NSData *)end_date description:(nullable NSString *)description successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSParameterAssert(experienceId);
    NSDictionary *dic =     @{@":id":experienceId,@":company_name":company_name,@"job_label_id":job_label_id,@"start_date":start_date,@"end_date":end_date,@"description":description};
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Update_Experience_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)updateExperienceWith_experienceId:(NSNumber *)experienceId successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSParameterAssert(experienceId);
    NSDictionary *dic = @{@":id":experienceId};
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Delete_Experience_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}



@end
