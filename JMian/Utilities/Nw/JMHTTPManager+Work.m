//
//  JMHTTPManager+Work.m
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Work.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (Work)


- (void)fetchWorkPaginateWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Work_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}
- (void)fetchWorkPaginateWith_city_ids:(nullable NSArray *)city_ids
                            company_id:(nullable NSNumber *)company_id
                              label_id:(nullable NSNumber *)label_id
                         work_label_id:(nullable NSNumber *)work_label_id
                             education:(nullable NSNumber *)education
                        experience_min:(nullable NSNumber *)experience_min
                        experience_max:(nullable NSNumber *)experience_max
                            salary_min:(nullable NSNumber *)salary_min
                            salary_max:(nullable NSNumber *)salary_max
                          subway_names:(nullable NSArray *)subway_names
                                status:(NSNumber * )status
                                  page:(nullable NSNumber *)page
                              per_page:(nullable NSNumber *)per_page
                          SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
       NSDictionary *dic =     @{
                                 @":city_ids":city_ids,
                                 @"company_id":company_id,
                                 @"label_id":label_id,
                                 @"work_label_id":work_label_id,
                                 @"education":education,
                                 @":experience_min":experience_min,
                                 @"experience_max":experience_max,
                                 @"salary_min":salary_min,
                                 @"salary_max":salary_max,
                                 @":subway_names":subway_names,
                                 @"status":status,
                                 @"page":page,
                                 @"per_page":per_page
                                 
                                 };
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Work_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


-(void)fetchWorkInfoWithWork_id:(NSNumber *)work_id SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSParameterAssert(work_id);
    NSString *url = [NSString stringWithFormat:@"%@/%@",Info_Work_URL,work_id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:url parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


@end
