//
//  JMHTTPManager+FetchCompanyInfo.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FetchCompanyInfo.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (FetchCompanyInfo)


- (void)fetchCompanyInfo_Id:(NSNumber *)companyId successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSParameterAssert(companyId);
    NSDictionary *dic = @{@":id":companyId};
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Fectch_CompanyInfo_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

@end
