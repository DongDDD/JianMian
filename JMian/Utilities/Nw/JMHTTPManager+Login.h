//
//  JMHTTPManager+Login.h
//  JMian
//
//  Created by Chitat on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (Login)

- (void)loginWithMode:(NSString *)mode phone:(NSString *)phone captcha:(NSString *)captcha sign_id:(nullable NSString *)sign_id successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


- (void)fetchUserInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)userChangeWithType:(nullable NSString *)type
                      step:(nullable NSString *)step
              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)logoutWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
