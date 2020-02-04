//
//  JMHTTPManager+GetGoodsInfo.h
//  JMian
//
//  Created by mac on 2020/1/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetGoodsInfo)
- (void)getGoodsInfoWithGoods_id:(NSString *)goods_id
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
