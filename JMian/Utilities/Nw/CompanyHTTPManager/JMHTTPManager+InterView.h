//
//  JMHTTPManager+InterView.h
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (InterView)

- (void)fetchInterViewListWithStatus:(NSString *)status
                            page:(NSString *)page
                        per_page:(NSString *)per_page

                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
