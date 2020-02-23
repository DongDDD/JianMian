//
//  JMHTTPManager+UpdateShopInfo.m
//  JMian
//
//  Created by mac on 2020/2/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+UpdateShopInfo.h"



@implementation JMHTTPManager (UpdateShopInfo)
- (void)updateShopInfoWithShop_id:(NSString *)shop_id
                        shop_logo:(NSString *)shop_logo
                      shop_poster:(NSString *)shop_poster
                      description:(NSString *)description
                           status:(NSString *)status
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Update_ShopInfo_URL stringByAppendingFormat:@"/%@",shop_id];

    NSDictionary *dic =  @{
                           @"shop_logo":shop_logo,
                           @"shop_poster":shop_poster,
                           @"description":description,
                           @"status":status,

                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
