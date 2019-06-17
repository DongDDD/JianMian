//
//  JMHTTPManager+UpdateInfo.m
//  JMian
//
//  Created by mac on 2019/4/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+UpdateInfo.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (UpdateInfo)

- (void)updateUserInfoWithCompany_position:(nullable NSString *)company_position
                                      type:(nullable NSNumber *)type
                                  password:(nullable NSString *)password
                                    avatar:(nullable NSString *)avatar
                                  nickname:(nullable NSString *)nickname
                                     email:(nullable NSString *)email
                                      name:(nullable NSString *)name
                                       sex:(nullable NSNumber *)sex
                                    ethnic:(nullable NSString *)ethnic
                                  birthday:(nullable NSString *)birthday
                                   address:(nullable NSString *)address
                                    number:(nullable NSString *)number
                               image_front:(nullable NSString *)image_front
                              image_behind:(nullable NSString *)image_behind
                                 user_step:(nullable NSString *)user_step
                           enterprise_step:(nullable NSString *)enterprise_step
                               real_status:(nullable NSString *)real_status
                              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"type"] = type;
    dic[@"password"] = password;
    dic[@"avatar"] = avatar;
    dic[@"nickname"] = nickname;
    dic[@"email"] = email;
    if(name) dic[@"name"] = name;
    if(company_position) dic[@"company_position"] = company_position;
    if(sex) dic[@"sex"] = sex;
    if(ethnic) dic[@"ethnic"] = ethnic;
    if(birthday) dic[@"birthday"] = birthday;
    if(address) dic[@"address"] = address;
    if(number) dic[@"number"] = number;
    if(image_front) dic[@"image_front"] = image_front;
    if(image_behind) dic[@"image_behind"] = image_behind;
    if(user_step) dic[@"user_step"] = user_step;
    if(enterprise_step) dic[@"enterprise_step"] = enterprise_step;
    if(real_status) dic[@"real_status"] = real_status;
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Update_info_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


@end
