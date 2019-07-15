//
//  JMHTTPManager+FectchVersionInfo.m
//  JMian
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchVersionInfo.h"

@implementation JMHTTPManager (FectchVersionInfo)

- (void)fectchVersionWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"type":@"1",
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_VersionInfo_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
