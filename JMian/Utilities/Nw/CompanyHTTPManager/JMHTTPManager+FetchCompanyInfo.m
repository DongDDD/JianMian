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


- (void)fetchCompanyInfo_Id:(NSString *)Id successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Fectch_CompanyInfo_URL stringByAppendingFormat:@"/%@",Id];
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

@end
