//
//  JMHTTPManager+GetManageGoodsList.m
//  JMian
//
//  Created by mac on 2020/2/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+GetManageGoodsList.h"

@implementation JMHTTPManager (GetManageGoodsList)
- (void)getManagerGoodsLIstWithKeyword:(NSString *)keyword
                          shop_id:(NSString *)shop_id
                           status:(NSString *)status
                             page:(NSString *)page
                         per_page:(NSString *)per_page
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    

    NSDictionary *dic =  @{
        @"keyword":keyword,
        @"shop_id":shop_id,
        @"status":status,
        @"page":page,
        @"per_page":per_page,

    };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_GoodsMangerList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
