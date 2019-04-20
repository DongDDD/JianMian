//
//  JMHTTPManager+VitaPaginate.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+VitaPaginate.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (VitaPaginate)

- (void)fetchVitaPaginateWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Vita_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


@end
