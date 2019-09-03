//
//  JMHTTPManager+FectchSpecialInfo.h
//  JMian
//
//  Created by mac on 2019/8/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchSpecialInfo)

- (void)getSpecialInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
