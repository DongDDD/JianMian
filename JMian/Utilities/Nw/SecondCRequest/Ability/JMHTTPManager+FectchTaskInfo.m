//
//  JMHTTPManager+FectchTaskInfo.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchTaskInfo.h"

@implementation JMHTTPManager (FectchTaskInfo)
- (void)fectchTaskInfo_taskID:(NSString *)taskID
         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Fectch_TaskInfo_URL stringByAppendingFormat:@"/%@",taskID];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
