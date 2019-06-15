//
//  JMHTTPManager+FectchInvoiceInfo.m
//  JMian
//
//  Created by mac on 2019/6/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchInvoiceInfo.h"

@implementation JMHTTPManager (FectchInvoiceInfo)

- (void)fectchInvoiceInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_InvoiceInfo_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
