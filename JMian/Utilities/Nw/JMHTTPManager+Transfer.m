//
//  JMHTTPManager+Transfer.m
//  JMian
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Transfer.h"

@implementation JMHTTPManager (Transfer)

- (void)transferWithAccount:(NSString *)account
                     amount:(NSString *)amount
                     remark:(NSString *)remark
               successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"account":account,
                           @"amount":amount,
                           @"remark":remark,

    };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Transfer_Money_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
