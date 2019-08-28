//
//  JMHTTPManager+FectchCommentInfo.h
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchCommentInfo)
- (void)fectchCommentInfoWithTask_order_id:(nullable NSString *)task_order_id
                                  order_id:(nullable NSString *)order_id
                                   user_id:(nullable NSString *)user_id
                                company_id:(nullable NSString *)company_id
                                      page:(nullable NSString *)page
                                  per_page:(nullable NSString *)per_page
                              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
