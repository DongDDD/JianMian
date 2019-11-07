//
//  JMHTTPManager+GetCityID.h
//  JMian
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (GetCityID)
- (void)getCityIdWithcity_name:(nullable NSString *)city_name
                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
