//
//  JMHTTPManager+Transfer.h
//  JMian
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (Transfer)
- (void)transferWithAccount:(NSString *)account
      amount:(NSString *)amount
      remark:(NSString *)remark
               successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
