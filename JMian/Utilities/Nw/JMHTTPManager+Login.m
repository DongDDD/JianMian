//
//  JMHTTPManager+Login.m
//  JMian
//
//  Created by Chitat on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Login.h"
#import "APIStringMacros.h"



@implementation JMHTTPManager (Login)

- (void)loginWithMode:(NSString *)mode phone:(NSString *)phone captcha:(NSString *)captcha sign_id:(nullable NSString *)sign_id successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSParameterAssert(mode);
    NSDictionary *dic = @{@"mode":mode,@"phone":phone,@"captcha":captcha,@"sign_id":sign_id};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Login_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
 
}


- (void)fetchUserInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:User_info_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

- (void)userChangeWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:User_Change parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}



@end
