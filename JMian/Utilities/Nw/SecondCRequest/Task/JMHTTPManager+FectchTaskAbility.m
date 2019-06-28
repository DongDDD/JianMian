//
//  JMHTTPManager+FectchTaskAbility.m
//  JMian
//
//  Created by mac on 2019/6/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchTaskAbility.h"

@implementation JMHTTPManager (FectchTaskAbility)

- (void)fetchTaskAbilityWithUser_id:(NSString *)user_id
                                        type_label_id:(NSString *)type_label_id
                                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Fectch_TaskAbility_URL stringByAppendingFormat:@"/%@",user_id];
    
    NSDictionary *dic =  @{
                           @"type_label_id":type_label_id
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
