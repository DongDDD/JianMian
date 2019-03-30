//
//  JMHTTPManager.m
//  JMian
//
//  Created by chitat on 2019/3/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"
#import "APIStringMacros.h"
#import "DimensMacros.h"
#import <AFNetworkActivityIndicatorManager.h>
@implementation JMHTTPManager

+ (instancetype)sharedInstance {
    static JMHTTPManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JMHTTPManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL_STRING] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return _manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(nullable NSURLSessionConfiguration *)configuration{
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        /// 配置
        [self _configHTTPService];
    }
    return self;
}

- (void)_configHTTPService{
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    /// config
    self.responseSerializer = responseSerializer;
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    /// 支持解析
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                      @"text/json",
                                                      @"text/javascript",
                                                      @"text/html",
                                                      @"text/plain",
                                                      @"text/html; charset=UTF-8",
                                                      nil];
    
    /// 开启网络监测
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusUnknown) {
            //            [JDStatusBarNotification showWithStatus:@"网络状态未知" styleName:JDStatusBarStyleWarning];
            //            [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
            NSLog(@"--- 未知网络 ---");
        }else if (status == AFNetworkReachabilityStatusNotReachable) {
            //            [JDStatusBarNotification showWithStatus:@"网络不给力，请检查网络" styleName:JDStatusBarStyleWarning];
            //            [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
            NSLog(@"--- 无网络 ---");
        }else{
            NSLog(@"--- 有网络 ---");
            //            [JDStatusBarNotification dismiss];
        }
    }];
    [self.reachabilityManager startMonitoring];
}

- (void)sendRequest:(JMHTTPRequest *)request {
    NSParameterAssert(request);
    NSURLSessionTask *task = [self sessionTaskForRequest:request];
    [task resume];
}

- (NSURLSessionTask *)sessionTaskForRequest:(JMHTTPRequest *)request {

    NSMutableURLRequest *urlRequest = nil;
    
    switch (request.method) {
        case JMRequestMethodGET:
            
            [self.requestSerializer setValue:kFetchMyDefault(@"token") forHTTPHeaderField:@"Authorization"];
           urlRequest = [self urlRequestForMethod:@"GET" request:request];
            break;
        case JMRequestMethodPOST:
            urlRequest = [self urlRequestForMethod:@"POST" request:request];
            break;
            
        default:
            break;
    }
    
    __block NSURLSessionDataTask *task = nil;
    task = [self dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse *response, NSDictionary * responseObject, NSError *error) {
        [self handleRequestResult:task request:request responseObject:responseObject error:error];
    }];

    
    return task;
}

- (NSMutableURLRequest *)urlRequestForMethod:(NSString *)method request:(JMHTTPRequest *)request {
    NSError *serializationError = nil;
    NSMutableURLRequest *urlRequest = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:request.path relativeToURL:self.baseURL] absoluteString] parameters:request.parameters error:&serializationError];
    if (serializationError) NSLog(@"serializationError=%@",serializationError);
    return urlRequest;
}

- (void)handleRequestResult:(NSURLSessionTask *)task request:(JMHTTPRequest *)request responseObject:(id)responseObject error:(NSError *)error {
    if (error) {
        // 处理错误
        NSError *parseError = [self _errorFromRequestWithTask:task httpResponse:(NSHTTPURLResponse *)task.response responseObject:responseObject error:error];
        //打印错误
        [self HTTPRequestLog:task body:request.parameters responseObject:responseObject error:parseError];
        //回调
        request.failureBlock(request, error);
        
    } else {
        /// 断言
        NSAssert([responseObject isKindOfClass:NSDictionary.class], @"responseObject is not an NSDictionary: %@", responseObject);
        /// 在这里判断数据是否正确
        /// 判断
        NSInteger statusCode = [responseObject[JMHTTPServiceResponseCodeKey] integerValue];
        if (statusCode == JMHTTPServiceResponseCodeSuccess) {
            
            if([request.path hasSuffix:@"login"]) {
                kSaveMyDefault(@"token", responseObject[JMHTTPServiceResponseDataKey][@"token"]);
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            [self HTTPRequestLog:task body:request.parameters responseObject:responseObject error:nil];
            request.successBlock(request, responseObject);
            
        }else{
            
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            userInfo[@"statusCode"] = @(statusCode);
            NSString *msgTips = responseObject[JMHTTPServiceResponseMsgKey];
            userInfo[@"msgTips"] = msgTips;
            if (task.currentRequest.URL != nil) userInfo[@"requestURL"] = task.currentRequest.URL.absoluteString;
            if (task.error != nil) userInfo[NSUnderlyingErrorKey] = task.error;
            NSError *requestError = [NSError errorWithDomain:NSCocoaErrorDomain code:statusCode userInfo:userInfo];
            [self HTTPRequestLog:task body:request.parameters responseObject:responseObject error:requestError];
            
        }
    }

}

#pragma mark - 打印请求日志
- (void)HTTPRequestLog:(NSURLSessionTask *)task body:params responseObject:(id)responseObject error:(NSError *)error {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>👇 REQUEST FINISH 👇>>>>>>>>>>>>>>>>>>>>>>>>>>");
    NSLog(@"Request%@=======>:%@", error?@"失败":@"成功", task.currentRequest.URL.absoluteString);
    NSLog(@"requestBody======>:%@", params);
    NSLog(@"requstHeader=====>:%@", task.currentRequest.allHTTPHeaderFields);
    NSLog(@"response=========>:%@", responseObject);
    NSLog(@"error============>:%@", error);
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<👆 REQUEST FINISH 👆<<<<<<<<<<<<<<<<<<<<<<<<<<");
}

- (NSError *)_errorFromRequestWithTask:(NSURLSessionTask *)task httpResponse:(NSHTTPURLResponse *)httpResponse responseObject:(NSDictionary *)responseObject error:(NSError *)error {
    /// 不一定有值，则HttpCode = 0;
    NSInteger HTTPCode = httpResponse.statusCode;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    /// default errorCode is MHHTTPServiceErrorConnectionFailed，意味着连接不上服务器
    NSInteger errorCode = HTTPCode;
    NSString *errorDesc = @"服务器出错了，请稍后重试~";
    return [NSError errorWithDomain:@"JMHTTPServiceErrorDomain" code:errorCode userInfo:userInfo];
}


@end
