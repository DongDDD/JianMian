//
//  JMHTTPManager+GetServiceID.m
//  JMian
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+GetServiceID.h"

@implementation JMHTTPManager (GetServiceID)

- (void)getServiceIdWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_CityID_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
