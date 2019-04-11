//
//  JMHTTPManager+Work.m
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Work.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager (Work)


- (void)fetchWorkPaginateWithSuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Paginate_Work_URL parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
}

-(void)fetchWorkInfoWithWork_id:(NSNumber *)work_id SuccessBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSParameterAssert(work_id);
    NSString *url = [NSString stringWithFormat:@"%@/%@",Info_Work_URL,work_id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:url parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];

}


@end
