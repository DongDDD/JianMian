//
//  JMHTTPRequest.m
//  JMian
//
//  Created by chitat on 2019/3/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPRequest.h"
#import "JMHTTPManager.h"

@implementation JMHTTPRequest

+ (instancetype)urlParametersWithMethod:(JMRequestMethod)method path:(NSString *)path parameters:(nullable NSDictionary *)parameters {
    return [[self alloc] initUrlParametersWithMethod:method path:path parameters:parameters];
}

- (instancetype)initUrlParametersWithMethod:(JMRequestMethod)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    if (self = [super init]) {    
        self.method = method;
        self.path = path;
        self.parameters = parameters;
    }
    return self;
}

- (void)sendRequestWithCompletionBlockWithSuccess:(JMHTTPRequestCompletionSuccessBlock)success  failure:(JMHTTPRequestCompletionFailureBlock)failure {
    self.successBlock = success;
    self.failureBlock = failure;
    [[JMHTTPManager sharedInstance] sendRequest:self];
}

@end
