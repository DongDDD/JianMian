//
//  JMHTTPManager+GetGoodsList.m
//  JMian
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+GetGoodsList.h"


@implementation JMHTTPManager (GetGoodsList)

- (void)getGoodsListWithShop_id:(NSString *)shop_id
                         status:(NSString *)status
                        keyword:(NSString *)keyword

                   successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
//    NSString *urlStr = [Get_GoodsList_URL stringByAppendingFormat:@"/%@",shop_id];
    
    NSDictionary *dic = @{
        @"shop_id":shop_id,
        @"status":status,

    };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_GoodsList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
