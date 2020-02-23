//
//  JMHTTPManager+UpdateShopInfo.h
//  JMian
//
//  Created by mac on 2020/2/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (UpdateShopInfo)
- (void)updateShopInfoWithShop_id:(NSString *)shop_id
                        shop_logo:(NSString *)shop_logo
                      shop_poster:(NSString *)shop_poster
                      description:(NSString *)description
                           status:(NSString *)status
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
