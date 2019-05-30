//
//  JMHTTPManager+CompanyLike.m
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CompanyLike.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (CompanyLike)



- (void)fetchListWith_type:(nullable NSString *)type
                          page:(nullable NSString *)page
                      per_page:(nullable NSString *)per_page
                SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =     @{
                              @"type":type,
                              @"page":page,
                              @"per_page":per_page
                              };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:List_Favorite_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)deleteLikeWith_Id:(nullable NSString *)Id
                  SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

        NSString *urlStr = [Delete_Favorite_URL stringByAppendingFormat:@"/%@",Id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)createLikeWith_type:(nullable NSString *)type
                       Id:(NSString *)Id
             SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSDictionary *dic =     @{
                              @"type":type,
                              @"id":Id
                              };
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Favorite_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

@end
