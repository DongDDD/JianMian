//
//  JMHTTPManager+GetGoodsList.h
//  JMian
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 mac. All rights reserved.
//


#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetGoodsList)
- (void)getGoodsListWithShop_id:(NSString *)shop_id
                         status:(NSString *)status
                        keyword:(NSString *)keyword

                   successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
