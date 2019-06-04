//
//  JMHTTPManager+GetLabels.h
//  JMian
//
//  Created by mac on 2019/6/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetLabels)

- (void)getLabels_Id:(nullable NSString *)Id
                        mode:(nullable NSString *)mode
                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
