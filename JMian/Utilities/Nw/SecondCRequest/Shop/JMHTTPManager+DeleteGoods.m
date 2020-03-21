//
//  JMHTTPManager+DeleteGoods.m
//  JMian
//
//  Created by mac on 2020/3/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+DeleteGoods.h"



@implementation JMHTTPManager (DeleteGoods)
- (void)deleteGoods_Id:(NSString *)Id
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Delete_Goods_URL stringByAppendingFormat:@"/%@",Id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
