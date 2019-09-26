//
//  JMHTTPManager+Vita.m
//  JMian
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Vita.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (Vita)

- (void)createVitaWith_work_status:(NSString *)work_status
                         education:(NSString *)education
                   work_start_date:(NSString *)work_start_date
                      job_label_id:(NSString *)job_label_id
                 industry_label_id:(nullable NSNumber *)industry_label_id
                           city_id:(nullable NSNumber *)city_id
                        salary_min:(NSString *)salary_min
                        salary_max:(NSString *)salary_max
                       description:(nullable NSString *)description
                            status:(nullable NSNumber *)status
                            user_step:(nullable NSNumber *)user_step
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    
    NSDictionary *dic = @{@"work_status":work_status,
                          @"education":education,
                          @"work_start_date":work_start_date,
                          @"job_label_id":job_label_id,
                          @"industry_label_id":industry_label_id,
                          @"city_id":city_id,
                          @"salary_min":salary_min,
                          @"salary_max":salary_max,
                          @"description":description,
                          @"status":status,
                          @"user_step":user_step
                          };

    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Vita_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)updateVitaWith_work_status:(nullable NSString *)work_status
                         education:(nullable NSString *)education
                   work_start_date:(nullable NSString *)work_start_date
                       description:(nullable NSString *)description
                        video_path:(nullable NSString *)video_path
                       video_cover:(nullable NSString *)video_cover
                       image_paths:(nullable NSArray *)image_paths
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSDictionary *dic = @{@"work_status":work_status,
                          @"education":education,
                          @"work_start_date":work_start_date,
                          @"description":description,
                          @"video_path":video_path,
                          @"video_cover":video_cover,
                          @"image_paths":image_paths
                          };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Update_Vita_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];

}

- (void)fetchVitPaginateWithCity_id:(nullable NSNumber *)city_id
                          education:(nullable NSNumber *)education
                       job_label_id:(nullable NSNumber *)job_label_id
                        work_year_s:(nullable NSNumber *)work_year_s
                        work_year_e:(nullable NSNumber *)work_year_e
                         salary_min:(nullable NSNumber *)salary_min
                         salary_max:(nullable NSNumber *)salary_max
                               page:(nullable NSNumber *)page
                           per_page:(nullable NSNumber *)per_page
                       successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic = @{@"city_id":city_id,
                          @"education":education,
                          @"work_year_s":work_year_s,
                          @"job_label_id":job_label_id,
                          @"work_year_e":work_year_e,
                          @"salary_min":salary_min,
                          @"salary_max":salary_max,
                          @"page":page,
                          @"per_page":per_page,
                          };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Vita_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];

}

- (void)fetchVitaInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Info_Vita_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];

}

- (void)fetchJobInfoWithId:(nullable NSString *)Id successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Info_Job_URL stringByAppendingFormat:@"/%@",Id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)addJobInfoWithJob_label_id:(NSString *)job_label_id
                 industry_label_id:(nullable NSString *)industry_label_id
                           city_id:(NSString *)city_id
                        salary_min:(NSString *)salary_min
                        salary_max:(NSString *)salary_max
                            status:(nullable NSString *)status
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSDictionary *dic = @{@"job_label_id":job_label_id,
                          @"industry_label_id":industry_label_id,
                          @"city_id":city_id,
                          @"salary_min":salary_min,
                          @"salary_max":salary_max,
                          @"status":status
                          };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Add_Job_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)deleteJobInfoWithId:(NSString *)Id SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Delete_Job_URL stringByAppendingFormat:@"/%@",Id];

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
