//
//  JMHTTPManager+FetchCompanyInfo.h
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FetchCompanyInfo)

- (void)fetchCompanyInfo_Id:(NSString *)Id successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
