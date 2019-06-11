//
//  JMHTTPManager+FectchMyTaskOrderList.h
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchMyTaskOrderList)

- (void)fectchTaskList_status:(nullable NSString *)status
                         page:(nullable NSString *)page
                     per_page:(nullable NSString *)per_page
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
