//
//  JMHTTPManager+DeleteGoods.h
//  JMian
//
//  Created by mac on 2020/3/9.
//  Copyright © 2020 mac. All rights reserved.
//


#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (DeleteGoods)
- (void)deleteGoods_Id:(NSString *)Id
          successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
