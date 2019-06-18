//
//  JMHTTPManager+FectchMoneyDetail.h
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchMoneyDetail)

- (void)fectchMoneyDetailListWithPage:(nullable NSString *)page
                       per_page:(nullable NSString *)per_page
                   successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
