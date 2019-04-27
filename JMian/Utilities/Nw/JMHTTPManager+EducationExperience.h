//
//  JMHTTPManager+EducationExperience.h
//  JMian
//
//  Created by chitat on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (EducationExperience)


- (void)createEducationExperienceWithSchool_name:(NSString *)school_name
                                       education:(NSString *)education
                                          s_date:(NSDate*)s_date
                                          e_date:(nullable NSDate *)e_date
                                           major:(NSString *)major
                                     description:(nullable NSString *)description
                                       user_step:(nullable NSString *)user_step
                                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)updateEducationExperienceWithEducationId:(NSString *)educationId
                                       education:(nullable NSString *)education
                                          s_date:(nullable NSDate*)s_date
                                          e_date:(nullable NSDate *)e_date
                                           major:(nullable NSString *)major
                                     description:(nullable NSString *)description
                                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)deleteEducationExperienceWith_experienceId:(NSString *)experienceId
                                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
