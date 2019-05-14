//
//  JMHTTPManager+VitaPaginate.h
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (VitaPaginate)

- (void)fetchVitaPaginateWithKeyword:(nullable NSString *)keyword
                                page:(nullable NSString *)page
                            per_page:(nullable NSString *)per_page
                        SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
