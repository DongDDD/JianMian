//
//  JMHTTPManager+FectchGreetList.m
//  JMian
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchGreetList.h"

@implementation JMHTTPManager (FectchGreetList)

- (void)getGreetList_keyword:(nullable NSString *)keyword
                mode:(nullable NSString *)mode
                     user_id:(nullable NSString *)user_id
                     page:(nullable NSString *)page
                     per_page:(nullable NSString *)per_page

        successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"keyword":keyword,@"mode":mode};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fetch_GreetList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)createGreet_text:(nullable NSString *)text
                        mode:(nullable NSString *)mode


                successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"text":text,@"mode":mode};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_Greet_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)deleteGreet_ID:(nullable NSString *)ID
          successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Delete_Greet_URL stringByAppendingFormat:@"/%@",ID];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
