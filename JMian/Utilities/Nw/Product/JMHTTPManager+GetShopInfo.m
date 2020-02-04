//
//  JMHTTPManager+GetShopInfo.m
//  JMian
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+GetShopInfo.h"


@implementation JMHTTPManager (GetShopInfo)
- (void)getShopInfoWithUser_id:(NSString *)user_id
successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic = @{@"user_id":user_id};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_ShopInfo_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
