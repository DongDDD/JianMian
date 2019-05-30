//
//  JMHTTPManager+Job.h
//  JMian
//
//  Created by chitat on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (Job)

- (void)updateJobWith_user_job_id:(NSString *)user_job_id
                     job_label_id:(nullable NSString *)job_label_id
                industry_label_id:(nullable NSString *)industry_label_id
                          city_id:(nullable NSString *)city_id
                       salary_min:(nullable NSString *)salary_min
                       salary_max:(nullable NSString *)salary_max
                           status:(nullable NSString *)status
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBloc;


@end

NS_ASSUME_NONNULL_END
