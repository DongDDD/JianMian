//
//  JMHTTPManager+VitaPaginate.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+VitaPaginate.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (VitaPaginate)

- (void)fetchVitaPaginateWith_city_id:(nullable NSString *)city_id
                                job_label_id:(nullable NSString *)job_label_id
                            education:(nullable NSString *)education
                         work_year_s:(nullable NSString *)work_year_s
                            work_year_e:(nullable NSString *)work_year_e
                         salary_min:(nullable NSString *)salary_min
                            salary_max:(nullable NSString *)salary_max
                              special_id:(nullable NSString *)special_id
                         page:(nullable NSString *)page
                            per_page:(nullable NSString *)per_page

                        SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSDictionary *dic = @{
                          @"city_id":city_id,
                          @"job_label_id":job_label_id,
                          @"education":education,
                          @"work_year_s":work_year_s,
                          @"work_year_e":work_year_e,
                          @"salary_min":salary_min,
                          @"salary_max":salary_max,
                          @"special_id":special_id,
                          @"page":page,
                          @"per_page":per_page
                          };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Vita_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


@end
