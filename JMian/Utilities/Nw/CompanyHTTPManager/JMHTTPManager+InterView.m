//
//  JMHTTPManager+InterView.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+InterView.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (InterView)

- (void)fetchInterViewListWithStatus:(NSString *)status
                            page:(NSString *)page
                        per_page:(NSString *)per_page

                   successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock{
    
    NSDictionary *dic = @{@"status":status,@"page":page,@"per_page":per_page};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:List_Interview_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
