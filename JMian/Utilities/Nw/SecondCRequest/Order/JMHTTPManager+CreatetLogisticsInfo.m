//
//  JMHTTPManager+CreatetLogisticsInfo.m
//  JMian
//
//  Created by mac on 2019/6/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+CreatetLogisticsInfo.h"

@implementation JMHTTPManager (CreatetLogisticsInfo)
- (void)createLogisticsInfoWithId:(NSString *)Id
          Logistics_label_id:(NSString *)logistics_label_id
                logistics_no:(NSString *)logistics_no
                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Create_LogisticsInfo_URL stringByAppendingFormat:@"/%@",Id];
    NSDictionary *dic =  @{
                           @"logistics_label_id":logistics_label_id,
                           @"logistics_no":logistics_no
                           };
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
