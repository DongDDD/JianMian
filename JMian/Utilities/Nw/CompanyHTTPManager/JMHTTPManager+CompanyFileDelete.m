//
//  JMHTTPManager+CompanyFileDelete.m
//  JMian
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CompanyFileDelete.h"

@implementation JMHTTPManager (CompanyFileDelete)


- (void)deleteCompanyFile_Id:(nullable NSString *)Id
                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [CompanyFile_Delete_URL stringByAppendingFormat:@"/%@",Id];
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


@end
