//
//  JMHTTPManager+GetShopInfo.h
//  JMian
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 mac. All rights reserved.
//


#import "JMHTTPManager.h"
#import "JMShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetShopInfo)
- (void)getShopInfoWithUser_id:(NSString *)user_id
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
