//
//  JMHTTPManager+Captcha.m
//  JMian
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Captcha.h"
#import "APIStringMacros.h"


@implementation JMHTTPManager (Captcha)


- (void)loginCaptchaWithPhone:(NSString *)phone mode:(NSNumber *)mode successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic = @{@"phone":phone,@"mode":mode};

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Login_Captcha_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

@end
