//
//  JMHTTPManager+MoneyWithDraw.h
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (MoneyWithDraw)
- (void)withdrawMoneyWithBank_card_id:(nullable NSString *)bank_card_id
                                    amount:(nullable NSString *)amount
                              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
