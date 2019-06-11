//
//  JMHTTPManager+FectchTaskOrderInfo.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchTaskOrderInfo.h"

@implementation JMHTTPManager (FectchTaskOrderInfo)

- (void)fectchTaskOrderInfo_taskID:(NSString *)taskID
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Fectch_TaskOrderInfo_URL stringByAppendingFormat:@"/%@",taskID];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
