//
//  JMHTTPManager+CompanyUpdateJob.h
//  JMian
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CompanyUpdateJob)

- (void)updateJobInfoWith_Id:(nullable NSString *)Id
                job_label_id:(nullable NSString *)job_label_id
           industry_label_id:(nullable NSString *)industry_label_id
                     city_id:(nullable NSString *)city_id
                  salary_min:(nullable NSString *)salary_min
                  salary_max:(nullable NSString *)salary_max
                      status:(nullable NSString * )status
                SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
