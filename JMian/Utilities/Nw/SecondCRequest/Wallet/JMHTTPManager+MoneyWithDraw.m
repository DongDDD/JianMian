//
//  JMHTTPManager+MoneyWithDraw.m
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+MoneyWithDraw.h"

@implementation JMHTTPManager (MoneyWithDraw)

- (void)withdrawMoneyWithBank_card_id:(nullable NSString *)bank_card_id
                                    amount:(nullable NSString *)amount
                              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"bank_card_id":bank_card_id,
                           @"amount":amount,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Money_Withdraw_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
