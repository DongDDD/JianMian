//
//  JMHTTPManager+Job.m
//  JMian
//
//  Created by chitat on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Job.h"

@implementation JMHTTPManager (Job)

- (void)updateJobWith_user_job_id:(NSString *)user_job_id
              job_label_id:(nullable NSString *)job_label_id
         industry_label_id:(nullable NSString *)industry_label_id
                   city_id:(nullable NSString *)city_id
                salary_min:(nullable NSString *)salary_min
                salary_max:(nullable NSString *)salary_max
                    status:(nullable NSString *)status
              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSParameterAssert(user_job_id);
    NSString *urlStr = [Update_job_URL stringByAppendingFormat:@"/%@",user_job_id];
    NSDictionary *dic =  @{
                           @"job_label_id":job_label_id,
                           @"industry_label_id":industry_label_id,
                           @"city_id":city_id,@"salary_min":salary_min,
                           @"city_id":city_id,@"salary_min":salary_min,
                           @"salary_max":salary_max,@"status":status
                           
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];

}
@end
