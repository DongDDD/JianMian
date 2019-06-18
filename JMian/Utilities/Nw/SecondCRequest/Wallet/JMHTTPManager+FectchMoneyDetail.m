//
//  JMHTTPManager+FectchMoneyDetail.m
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchMoneyDetail.h"

@implementation JMHTTPManager (FectchMoneyDetail)
- (void)fectchMoneyDetailListWithPage:(nullable NSString *)page
                        per_page:(nullable NSString *)per_page
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"page":page,
                           @"per_page":per_page,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_MoneyDetails_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
