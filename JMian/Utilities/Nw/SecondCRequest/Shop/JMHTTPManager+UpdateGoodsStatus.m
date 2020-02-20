//
//  JMHTTPManager+UpdateGoodsStatus.m
//  JMian
//
//  Created by mac on 2020/2/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+UpdateGoodsStatus.h"


@implementation JMHTTPManager (UpdateGoodsStatus)

- (void)upDateGoodsStatusWithGoods_id:(NSString *)goods_id
                               status:(NSString *)status
                         successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Update_GoodsStatus_URL stringByAppendingFormat:@"/%@",goods_id];
    NSDictionary *dic =  @{
//        @"status":status,
        @"status":status,
    };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
 
@end
