//
//  JMHTTPManager+GetLabels.m
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+GetLabels.h"

@implementation JMHTTPManager (GetLabels)

- (void)getLabels_Id:(nullable NSString *)Id
                         mode:(nullable NSString *)mode
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"id":Id,@"mode":mode};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_Labels_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
