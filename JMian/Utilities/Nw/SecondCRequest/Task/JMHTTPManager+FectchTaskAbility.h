//
//  JMHTTPManager+FectchTaskAbility.h
//  JMian
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchTaskAbility)
- (void)fetchTaskAbilityWithUser_id:(NSString *)user_id
                      type_label_id:(NSString *)type_label_id
                       successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
