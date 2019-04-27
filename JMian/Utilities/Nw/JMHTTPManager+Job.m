//
//  JMHTTPManager+Job.m
//  JMian
//
//  Created by chitat on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Job.h"

@implementation JMHTTPManager (Job)

- (void)updateJobWithJobId:(NSNumber *)jobId
              job_label_id:(nullable NSNumber *)job_label_id
         industry_label_id:(nullable NSNumber *)industry_label_id
                   city_id:(nullable NSNumber *)city_id
                salary_min:(nullable NSNumber *)salary_min
                salary_max:(nullable NSNumber *)salary_max
                    status:(nullable NSNumber *)status
              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSParameterAssert(jobId);
    NSString *urlStr = [Update_job_URL stringByAppendingFormat:@"/%@",job_label_id];
    NSDictionary *dic =  @{@"jobId":jobId,@"industry_label_id":industry_label_id,@"city_id":city_id,@"salary_min":salary_min,@"salary_max":salary_max,@"status":status};
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];

}
@end
