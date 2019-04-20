//
//  JMHTTPManager+CreateExperience.h
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CreateExperience)

- (void)createExperienceWithCompany_name:(NSString *)company_name
                            job_label_id:(NSNumber *)job_label_id
                              start_date:(NSDate *)start_date
                                end_date:(nullable NSDate *)end_date
                               user_step:(NSString *)user_step
                             description:(NSString *)description
                            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)updateExperienceWith_experienceId:(NSNumber *)experienceId
                             company_name:(nullable NSString *)company_name
                             job_label_id:(nullable NSNumber *)job_label_id
                               start_date:(nullable NSDate *)start_date
                                 end_date:(nullable NSDate *)end_date
                              description:(nullable NSString *)description
                             successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
