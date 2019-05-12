//
//  JMHTTPManager+PositionDesired.m
//  JMian
//
//  Created by mac on 2019/4/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+PositionDesired.h"
#import "APIStringMacros.h"


@implementation JMHTTPManager (PositionDesired)

- (void)fetchPositionLabelsWithMyId:(nullable NSString *)myId mode:(NSString *)mode successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {

    NSDictionary *dic = @{@"id":myId,@"mode":mode};
  
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Position_label_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}


- (void)fetchCityListWithMyId:(nullable NSString *)myId mode:(NSString *)mode successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    
    NSDictionary *dic = @{@"id":myId,@"mode":mode};
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:City_List_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}



@end
