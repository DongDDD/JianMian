//
//  JMHTTPManager+Work.h
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (Work)

- (void)fetchWorkPaginateWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


-(void)fetchWorkInfoWithWork_id:(NSNumber *)work_id SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

//发布职位列表
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
                          SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
