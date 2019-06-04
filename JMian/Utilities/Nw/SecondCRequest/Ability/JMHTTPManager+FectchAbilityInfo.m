//
//  JMHTTPManager+FectchAbilityInfo.m
//  JMian
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchAbilityInfo.h"

@implementation JMHTTPManager (FectchAbilityInfo)

- (void)fectchAbilityDetailInfo_Id:(nullable NSString *)Id

                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Fectch_AbilityInfo_URL stringByAppendingFormat:@"/%@",Id];

  
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
