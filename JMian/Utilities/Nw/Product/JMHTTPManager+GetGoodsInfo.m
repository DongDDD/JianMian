//
//  JMHTTPManager+GetGoodsInfo.m
//  JMian
//
//  Created by mac on 2020/1/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+GetGoodsInfo.h"

@implementation JMHTTPManager (GetGoodsInfo)

- (void)getGoodsInfoWithGoods_id:(NSString *)goods_id
successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Get_GoodsInfo_URL stringByAppendingFormat:@"/%@",goods_id];    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
