//
//  JMHTTPManager+FectchGreetList.h
//  JMian
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchGreetList)
- (void)getGreetList_keyword:(nullable NSString *)keyword
                        mode:(nullable NSString *)mode
                     user_id:(nullable NSString *)user_id
                        page:(nullable NSString *)page
                    per_page:(nullable NSString *)per_page

                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)createGreet_text:(nullable NSString *)text
                    mode:(nullable NSString *)mode
            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)deleteGreet_ID:(nullable NSString *)ID
          successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
