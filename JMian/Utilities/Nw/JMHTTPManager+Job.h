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

- (void)updateJobWithJobId:(NSNumber *)jobId
              job_label_id:(nullable NSNumber *)job_label_id
         industry_label_id:(nullable NSNumber *)industry_label_id
                   city_id:(nullable NSNumber *)city_id
                salary_min:(nullable NSNumber *)salary_min
                salary_max:(nullable NSNumber *)salary_max
                status:(nullable NSNumber *)status
                                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


@end

NS_ASSUME_NONNULL_END
