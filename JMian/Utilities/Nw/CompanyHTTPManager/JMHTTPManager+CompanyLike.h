//
//  JMHTTPManager+CompanyLike.h
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CompanyLike)

- (void)fetchListWith_type:(nullable NSString *)type
                      page:(nullable NSString *)page
                  per_page:(nullable NSString *)per_page
                      mode:(nullable NSString *)mode
              SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

- (void)deleteLikeWith_Id:(nullable NSString *)Id
                     mode:(nullable NSString *)mode
             SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


- (void)createLikeWith_type:(nullable NSString *)type
                         Id:(NSString *)Id
                       mode:(NSString *)mode
               SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
