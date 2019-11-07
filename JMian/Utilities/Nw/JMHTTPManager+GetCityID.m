//
//  JMHTTPManager+GetCityID.m
//  JMian
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+GetCityID.h"

@implementation JMHTTPManager (GetCityID)

- (void)getCityIdWithcity_name:(nullable NSString *)city_name
        successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"city_name":city_name};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_CityID_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
