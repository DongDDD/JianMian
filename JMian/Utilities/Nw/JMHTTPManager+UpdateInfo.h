//
//  JMHTTPManager+UpdateInfo.h
//  JMian
//
//  Created by mac on 2019/4/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (UpdateInfo)

- (void)updateUserInfoType:(nullable NSNumber *)type
                  password:(nullable NSString *)password
                    avatar:(nullable NSString *)avatar
                  nickname:(nullable NSString *)nickname
                     email:(nullable NSString *)email
                      name:(nullable NSString *)name
                       sex:(nullable NSNumber *)sex
                    ethnic:(nullable NSString *)ethnic
                  birthday:(nullable NSString *)birthday
                   address:(nullable NSString *)address
                    number:(nullable NSString *)number
               image_front:(nullable NSString *)image_front
              image_behind:(nullable NSString *)image_behind
                 user_step:(nullable NSString *)user_step
           enterprise_step:(nullable NSString *)enterprise_step
               real_status:(nullable NSString *)real_status
              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


@end

NS_ASSUME_NONNULL_END
