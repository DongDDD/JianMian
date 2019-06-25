//
//  JMHTTPManager+DeletePartTimeJobVita.m
//  JMian
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+DeletePartTimeJobVita.h"

@implementation JMHTTPManager (DeletePartTimeJobVita)

- (void)deleteAbilityVita_Id:(NSString *)Id
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Delete_AbilityVita_URL stringByAppendingFormat:@"/%@",Id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
