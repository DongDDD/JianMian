//
//  JMHTTPManager+FectchAbilityInfo.h
//  JMian
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchAbilityInfo)
- (void)fectchAbilityDetailInfo_Id:(nullable NSString *)Id
                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
