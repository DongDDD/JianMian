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


-(void)fetchWorkInfoWith_Id:(NSString *)Id SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

//获取 发布 or 下线职位列表
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
                          SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
//发布职位请求
- (void)postCreateWorkWith_city_id:(NSString *)city_id
                     work_label_id:(NSString *)work_label_id
                         work_name:(NSString *)work_name
                         education:(NSString *)education
               work_experience_min:(NSString *)work_experience_min
               work_experience_max:(NSString *)work_experience_max
                        salary_min:(NSString *)salary_min
                        salary_max:(NSString *)salary_max
                       description:(NSString *)description
                           address:(NSString * )address
                         longitude:(NSString *)longitude
                          latitude:(NSString *)latitude
                            status:(NSString *)status
                         label_ids:(nullable NSArray *)label_ids
                      SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


- (void)updateWorkWith_Id:(NSString *)Id
                  city_id:(NSString *)city_id
            work_label_id:(NSString *)work_label_id
                work_name:(NSString *)work_name
                education:(NSString *)education
      work_experience_min:(NSString *)work_experience_min
      work_experience_max:(NSString *)work_experience_max
               salary_min:(NSString *)salary_min
               salary_max:(NSString *)salary_max
              description:(NSString *)description
                  address:(NSString * )address
                longitude:(NSString *)longitude
                 latitude:(NSString *)latitude
                   status:(NSString *)status
                label_ids:(nullable NSArray *)label_ids
             SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
