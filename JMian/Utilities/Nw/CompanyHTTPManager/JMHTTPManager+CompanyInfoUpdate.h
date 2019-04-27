//
//  JMHTTPManager+CompanyInfoUpdate.h
//  JMian
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CompanyInfoUpdate)

- (void)updateCompanyInfo_Id:(nullable NSString *)Id
                company_name:(nullable NSString *)company_name
                    nickname:(nullable NSString *)nickname
                abbreviation:(nullable NSString *)abbreviation
                   logo_path:(nullable NSString *)logo_path
                  video_path:(nullable NSString *)video_path
                   work_time:(nullable NSString *)work_time
                   work_week:(nullable NSString *)work_week
               type_label_id:(nullable NSString *)type_label_id
           industry_label_id:(nullable NSString *)industry_label_id
                   financing:(nullable NSString *)financing
                    employee:(nullable NSString *)employee
                     address:(nullable NSString *)address
                         url:(nullable NSString *)url
                   longitude:(nullable NSString *)longitude
                    latitude:(nullable NSString *)latitude
                 description:(nullable NSString *)description
                  image_path:(nullable NSString *)image_path
                    label_id:(nullable NSString *)label_id
                      subway:(nullable NSArray *)subway
                   corporate:(nullable NSString *)corporate
                 reg_capital:(nullable NSString *)reg_capital
                    reg_date:(nullable NSString *)reg_date
                 reg_address:(nullable NSString *)reg_address
         unified_credit_code:(nullable NSString *)unified_credit_code
              business_scope:(nullable NSString *)business_scope
                license_path:(nullable NSString *)license_path
                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
