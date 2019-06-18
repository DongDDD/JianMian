//
//  JMHTTPManager+PayMoney.m
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+PayMoney.h"

@implementation JMHTTPManager (PayMoney)

- (void)payMoneyOrder_no:(NSString *)no
                  amount:(NSString *)amount

                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    
    NSDictionary *dic =  @{
                           @"no":no,
                           @"amount":amount
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Pay_Money_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
