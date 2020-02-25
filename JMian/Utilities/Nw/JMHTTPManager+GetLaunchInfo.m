//
//  JMHTTPManager+GetLaunchInfo.m
//  JMian
//
//  Created by mac on 2020/2/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+GetLaunchInfo.h"

 
@implementation JMHTTPManager (GetLaunchInfo)
- (void)getLaunchInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Launch_Activity_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
