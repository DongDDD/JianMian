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
                         education:(NSNumber *)education
                   work_start_date:(NSDate *)work_start_date
                      job_label_id:(NSString *)job_label_id
                 industry_label_id:(nullable NSNumber *)industry_label_id
                           city_id:(NSNumber *)city_id
                        salary_min:(NSNumber *)salary_min
                        salary_max:(NSNumber *)salary_max
                       description:(nullable NSString *)description
                            status:(nullable NSNumber *)status
                         user_step:(nullable NSNumber *)user_step
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock ;


@end

NS_ASSUME_NONNULL_END
