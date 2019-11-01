//
//  JMHTTPManager+FectchSpecialInfo.m
//  JMian
//
//  Created by mac on 2019/8/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchSpecialInfo.h"

@implementation JMHTTPManager (FectchSpecialInfo)

- (void)getSpecialInfoWithMode:(nullable NSString *)mode
                          SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSDictionary *dic =  @{@"mode":mode};

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Special_Activity_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
