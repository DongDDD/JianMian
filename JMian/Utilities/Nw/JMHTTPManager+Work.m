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
                            company_id:(nullable NSString *)company_id
                              label_id:(nullable NSString *)label_id
                         work_label_id:(nullable NSString *)work_label_id
                             education:(nullable NSString *)education
                        experience_min:(nullable NSString *)experience_min
                        experience_max:(nullable NSString *)experience_max
                            salary_min:(nullable NSString *)salary_min
                            salary_max:(nullable NSString *)salary_max
                          subway_names:(nullable NSArray *)subway_names
                                status:(NSString * )status
                                  page:(nullable NSString *)page
                              per_page:(nullable NSString *)per_page
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


-(void)fetchWorkInfoWith_Id:(NSString *)Id SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Info_Work_URL stringByAppendingFormat:@"/%@",Id];

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)postCreateWorkWith_city_id:(NSString *)city_id
                     work_label_id:(NSString *)work_label_id
                         work_name:(NSString *)work_name
                         education:(NSNumber *)education
               work_experience_min:(NSNumber *)work_experience_min
               work_experience_max:(NSNumber *)work_experience_max
                        salary_min:(NSNumber *)salary_min
                        salary_max:(NSNumber *)salary_max
                       description:(NSString *)description
                           address:(NSString * )address
                         longitude:(NSString *)longitude
                          latitude:(NSString *)latitude
                            status:(NSString *)status
                         label_ids:(nullable NSArray *)label_ids
                      SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =     @{
                              @"city_id":city_id,
                              @"work_label_id":work_label_id,
                              @"work_name":work_name,
                              @"education":education,
                              @"work_experience_min":work_experience_min,
                              @"work_experience_max":work_experience_max,
                              @"salary_min":salary_min,
                              @"salary_max":salary_max,
                              @"description":description,
                              @"address":address,
                              @"longitude":longitude,
                              @"latitude":latitude,
                              @"status":status,
                              @"label_ids":label_ids
                              
                              };
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Work_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}



@end
