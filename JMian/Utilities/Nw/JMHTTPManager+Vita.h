//
//  JMHTTPManager+Vita.h
//  JMian
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (Vita)


- (void)createVitaWith_work_status:(NSNumber *)work_status
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
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)updateVitaWith_work_status:(nullable NSString *)work_status
                         education:(nullable NSNumber *)education
                   work_start_date:(nullable NSDate *)work_start_date
                        description:(nullable NSString *)description
                            video_path:(nullable NSString *)video_path
                         image_paths:(nullable NSArray *)image_paths
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


- (void)fetchVitPaginateWithCity_id:(nullable NSNumber *)city_id
                         education:(nullable NSNumber *)education
                   job_label_id:(nullable NSNumber *)job_label_id
                      work_year_s:(nullable NSNumber *)work_year_s
                 work_year_e:(nullable NSNumber *)work_year_e
                        salary_min:(nullable NSNumber *)salary_min
                        salary_max:(nullable NSNumber *)salary_max
                       page:(nullable NSNumber *)page
                            per_page:(nullable NSNumber *)per_page
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock ;


- (void)fetchVitaInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)fetchJobInfoWithId:(nullable NSString *)Id successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)addJobInfoWithJob_label_id:(NSString *)job_label_id
                 industry_label_id:(nullable NSString *)industry_label_id
                           city_id:(NSString *)city_id
                        salary_min:(NSString *)salary_min
                        salary_max:(NSString *)salary_max
                            status:(nullable NSString *)status
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
