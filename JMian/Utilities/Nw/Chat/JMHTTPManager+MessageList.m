//
//  JMHTTPManager+MessageList.m
//  JMian
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+MessageList.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (MessageList)


- (void)fecthMessageList_mode:(NSString *)mode
              successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"mode":mode};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Chat_List_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
