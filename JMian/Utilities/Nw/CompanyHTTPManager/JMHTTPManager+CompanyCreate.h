//
//  JMHTTPManager+CompanyCreate.h
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CompanyCreate)

- (void)createCompanyWithCompany_name:(NSString *)company_name
                     company_position:(NSString *)company_position
                             nickname:(nullable NSString *)nickname
                               avatar:(nullable NSString *)avatar
                      enterprise_step:(nullable NSString *)enterprise_step
                         abbreviation:(nullable NSString *)abbreviation
                            logo_path:(nullable NSString *)logo_path
                           video_path:(nullable NSString *)video_path
                            work_time:(nullable NSString *)work_time
                            work_week:(nullable NSString *)work_week
                        type_label_id:(nullable NSString *)type_label_id
                    industry_label_id:(nullable NSString *)industry_label_id
                            financing:(nullable NSString *)financing
                             employee:(nullable NSString *)employee
                              city_id:(nullable NSString *)city_id
                              address:(nullable NSString *)address
                                  url:(nullable NSString *)url
                            longitude:(nullable NSString *)longitude
                             latitude:(nullable NSString *)latitude
                          description:(nullable NSString *)description
                           image_path:(nullable NSString *)image_path
                             label_id:(nullable NSString *)label_id
                               subway:(nullable NSString *)subway
                                 line:(nullable NSString *)line
                              station:(nullable NSString *)station
                            corporate:(nullable NSString *)corporate
                          reg_capital:(nullable NSString *)reg_capital
                             reg_date:(nullable NSString *)reg_date
                          reg_address:(nullable NSString *)reg_address
                  unified_credit_code:(nullable NSString *)unified_credit_code
                       business_scope:(nullable NSString *)business_scope
                         license_path:(nullable NSString *)license_path
                               status:(nullable NSString *)status

                         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
