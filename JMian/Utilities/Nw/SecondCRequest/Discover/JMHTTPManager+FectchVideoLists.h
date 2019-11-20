//
//  JMHTTPManager+FectchVideoLists.h
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchVideoLists)

- (void)fectchVideoList_mode:(NSString *)mode
                     city_id:(nullable NSString *)city_id
                        type:(nullable NSString *)type
               contact_phone:(nullable NSString *)contact_phone
                    per_page:(nullable NSString *)per_page
                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;

-(void)recordLookTimesWithVideoID:(NSString *)videoID
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
