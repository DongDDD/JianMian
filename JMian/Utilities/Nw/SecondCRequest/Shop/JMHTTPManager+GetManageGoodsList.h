//
//  JMHTTPManager+GetManageGoodsList.h
//  JMian
//
//  Created by mac on 2020/2/8.
//  Copyright © 2020 mac. All rights reserved.
//


#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetManageGoodsList)
- (void)getManagerGoodsLIstWithKeyword:(NSString *)keyword
     shop_id:(NSString *)shop_id
      status:(NSString *)status
        page:(NSString *)page
    per_page:(NSString *)per_page
successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
