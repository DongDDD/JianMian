//
//  JMHTTPManager+GetMyShopInfo.m
//  JMian
//
//  Created by mac on 2020/2/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+GetMyShopInfo.h"



@implementation JMHTTPManager (GetMyShopInfo)
- (void)getMyShopInfoWithShop_id:(NSString *)shop_id
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Fectch_MyShopInfo_URL stringByAppendingFormat:@"/%@",shop_id];

 
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
 
@end
