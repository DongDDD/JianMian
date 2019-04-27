//
//  JMHTTPManager+CompanyInfoUpdate.m
//  JMian
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CompanyInfoUpdate.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (CompanyInfoUpdate)


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

                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic = @{@"company_name":company_name,
                          @"nickname":nickname,
                          @"abbreviation":abbreviation,
                          @"logo_path":logo_path,
                          @"video_path":video_path,
                          @"work_time":work_time,
                          @"work_week":work_week,
                          @"type_label_id":type_label_id,
                          @"industry_label_id":industry_label_id,
                          @"financing":financing,
                          @"employee":employee,
                          @"address":address,
                          @"url":url,
                          @"longitude":longitude,
                          @"latitude":latitude,
                          @"description":description,
                          @"image_path":image_path,
                          @"label_id":label_id,
                          @"subway":subway,
                          @"corporate":corporate,
                          @"reg_capital":reg_capital,
                          @"reg_date":reg_date,
                          @"reg_address":reg_address,
                          @"unified_credit_code":unified_credit_code,
                          @"business_scope":business_scope,
                          @"license_path":license_path,
                          
                          };
    
    
    NSString *urlStr = [Update_CompanyInfo_URL stringByAppendingFormat:@"/%@",Id];
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

@end
