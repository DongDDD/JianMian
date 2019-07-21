//
//  JMHTTPManager+FectchProtocalInfo.m
//  JMian
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchProtocalInfo.h"

@implementation JMHTTPManager (FectchProtocalInfo)

- (void)fectchProtocalInfo_user_id:(nullable NSString *)user_id

                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Fectch_Protocal_URL stringByAppendingFormat:@"/%@",user_id];

//    NSDictionary *dic =  @{
//                           @"user_id":user_id,
//                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
