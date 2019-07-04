//
//  JMHTTPManager+FectchTplLIst.m
//  JMian
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchTplLIst.h"

@implementation JMHTTPManager (FectchTplLIst)

- (void)getTplList_type:(nullable NSString *)type
            foreign_key:(nullable NSString *)foreign_key
                 status:(nullable NSString *)status
                   page:(nullable NSString *)page
               per_page:(nullable NSString *)per_page

           successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"type":type,
                           @"foreign_key":foreign_key,
                           @"status":status,
                           @"page":page,
                           @"per_page":per_page,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_TplList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
