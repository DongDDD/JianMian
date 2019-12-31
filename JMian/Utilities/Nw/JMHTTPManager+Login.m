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

- (void)userChangeWithType:(nullable NSString *)type
                      step:(nullable NSString *)step
              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
//    NSString *urlStr = [User_Change stringByAppendingFormat:@"/%@",type];
//    NSString *urlStr2 = [urlStr stringByAppendingFormat:@"/%@",step];

    NSDictionary *dic = @{@"type":type,@"step":step};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:User_Change parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)logoutWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:logout_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}





@end
