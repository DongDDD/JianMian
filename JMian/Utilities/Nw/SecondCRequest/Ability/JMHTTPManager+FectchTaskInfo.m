//
//  JMHTTPManager+FectchTaskInfo.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchTaskInfo.h"

@implementation JMHTTPManager (FectchTaskInfo)
- (void)fectchTaskInfo_Id:(NSString *)Id
         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Fectch_TaskInfo_URL stringByAppendingFormat:@"/%@",Id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
