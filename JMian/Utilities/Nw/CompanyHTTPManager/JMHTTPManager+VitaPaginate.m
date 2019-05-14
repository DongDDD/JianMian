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

- (void)fetchVitaPaginateWithKeyword:(nullable NSString *)keyword
                                page:(nullable NSString *)page
                            per_page:(nullable NSString *)per_page
                        SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSDictionary *dic = @{@"keyword":keyword,@"page":page,@"per_page":per_page};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Vita_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


@end
