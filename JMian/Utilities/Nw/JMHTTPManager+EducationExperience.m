//
//  JMHTTPManager+EducationExperience.m
//  JMian
//
//  Created by chitat on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+EducationExperience.h"

@implementation JMHTTPManager (EducationExperience)

- (void)createEducationExperienceWithSchool_name:(NSString *)school_name
                            education:(NSString *)education
                              s_date:(NSDate*)s_date
                                e_date:(nullable NSDate *)e_date
                             major:(NSString *)major
                               description:(nullable NSString *)description
                                     user_step:(nullable NSString *)user_step
                            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    
    NSDictionary *dic = @{@"school_name":school_name,@"education":education,@"major":major,@"s_date":s_date,@"e_date":e_date,@"description":description,@"user_step":user_step};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_EducationExperience_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)updateEducationExperienceWithEducationId:(NSString *)educationId
                                       education:(nullable NSString *)education
                                          s_date:(nullable NSDate*)s_date
                                          e_date:(nullable NSDate *)e_date
                                           major:(nullable NSString *)major
                                     description:(nullable NSString *)description
                                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSParameterAssert(educationId);
    NSString *urlStr = [Update_EducationExperience_URL stringByAppendingFormat:@"/%@",educationId];
    NSDictionary *dic =  @{@"education":education,@"s_date":s_date,@"e_date":e_date,@"major":major,@"description":description};
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)deleteEducationExperienceWith_experienceId:(NSString *)experienceId
                             successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSParameterAssert(experienceId);
    NSString *urlStr = [Delete_EducationExperience_URL stringByAppendingFormat:@"/%@",experienceId];
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
