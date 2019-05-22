//
//  JMHTTPManager+VitaPaginate.h
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (VitaPaginate)

- (void)fetchVitaPaginateWith_city_id:(nullable NSString *)city_id
                         job_label_id:(nullable NSString *)job_label_id
                            education:(nullable NSString *)education
                          work_year_s:(nullable NSString *)work_year_s
                          work_year_e:(nullable NSString *)work_year_e
                           salary_min:(nullable NSString *)salary_min
                           salary_max:(nullable NSString *)salary_max
                                 page:(nullable NSString *)page
                             per_page:(nullable NSString *)per_page
                         SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
