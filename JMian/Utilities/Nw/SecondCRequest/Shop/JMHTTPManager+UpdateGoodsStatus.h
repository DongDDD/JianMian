//
//  JMHTTPManager+UpdateGoodsStatus.h
//  JMian
//
//  Created by mac on 2020/2/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (UpdateGoodsStatus)
- (void)upDateGoodsStatusWithGoods_id:(NSString *)Goods_id
                               status:(NSString *)status
                         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
