//
//  JMHTTPManager+DeleteWork.m
//  JMian
//
//  Created by mac on 2019/9/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+DeleteWork.h"

@implementation JMHTTPManager (DeleteWork)
- (void)deleteWorkWithId:(NSString *)Id
            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Delete_Work_URL stringByAppendingFormat:@"/%@",Id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
