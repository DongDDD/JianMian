//
//  JMHTTPManager+FectchProtocalInfo.h
//  JMian
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchProtocalInfo)
- (void)fectchProtocalInfo_user_id:(nullable NSString *)user_id
                      successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
