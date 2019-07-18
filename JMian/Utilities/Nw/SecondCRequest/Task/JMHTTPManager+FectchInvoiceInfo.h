//
//  JMHTTPManager+FectchInvoiceInfo.h
//  JMian
//
//  Created by mac on 2019/6/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchInvoiceInfo)

-(void)fectchInvoiceInfoWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
