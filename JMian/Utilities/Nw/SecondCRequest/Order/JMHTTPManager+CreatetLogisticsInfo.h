//
//  JMHTTPManager+CreatetLogisticsInfo.h
//  JMian
//
//  Created by mac on 2019/6/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (CreatetLogisticsInfo)
- (void)createLogisticsInfoWithId:(NSString *)Id
               Logistics_label_id:(NSString *)logistics_label_id
                     logistics_no:(NSString *)logistics_no
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBloc;
@end

NS_ASSUME_NONNULL_END
