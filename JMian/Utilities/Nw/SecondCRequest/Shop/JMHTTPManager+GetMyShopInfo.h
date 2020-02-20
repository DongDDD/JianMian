//
//  JMHTTPManager+GetMyShopInfo.h
//  JMian
//
//  Created by mac on 2020/2/20.
//  Copyright © 2020 mac. All rights reserved.
//


#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetMyShopInfo)
- (void)getMyShopInfoWithShop_id:(NSString *)shop_id
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
