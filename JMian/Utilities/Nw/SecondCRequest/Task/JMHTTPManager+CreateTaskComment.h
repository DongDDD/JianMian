//
//  JMHTTPManager+CreateTaskComment.h
//  JMian
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CreateTaskComment)

- (void)createTaskCommentWithForeign_key:(NSString *)foreign_key
                              reputation:(NSString *)reputation
                      commentDescription:(NSString *)commentDescription

                            successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
