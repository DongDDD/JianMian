//
//  JMHTTPManager+GetLaunchInfo.h
//  JMian
//
//  Created by mac on 2020/2/25.
//  Copyright © 2020 mac. All rights reserved.
//

 

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetLaunchInfo)
- (void)getLaunchInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
