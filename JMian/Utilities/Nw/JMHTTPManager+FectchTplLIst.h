//
//  JMHTTPManager+FectchTplLIst.h
//  JMian
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchTplLIst)
- (void)getTplList_type:(nullable NSString *)type
            foreign_key:(nullable NSString *)foreign_key
                 status:(nullable NSString *)status
                   page:(nullable NSString *)page
               per_page:(nullable NSString *)per_page

           successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
