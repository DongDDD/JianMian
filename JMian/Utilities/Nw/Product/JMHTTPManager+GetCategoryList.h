//
//  JMHTTPManager+GetCategoryList.h
//  JMian
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 mac. All rights reserved.
//



#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetCategoryList)
- (void)getCategoryListWithFormat:(NSString *)format
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
