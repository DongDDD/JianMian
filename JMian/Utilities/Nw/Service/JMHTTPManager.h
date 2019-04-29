//
//  JMHTTPManager.h
//  JMian
//
//  Created by chitat on 2019/3/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "JMHTTPRequest.h"
#import "JMHTTPConstant.h"
#import "APIStringMacros.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,JMHTTPServiceResponseCode){
    JMHTTPServiceResponseCodeSuccess = 200,
    JMHTTPServiceResponseCodeTokenExpired = 403,
} ;

@interface JMHTTPManager : AFHTTPSessionManager

//单例
+ (instancetype)sharedInstance;
//发起请求
- (void)sendRequest:(JMHTTPRequest *)request;

@end

NS_ASSUME_NONNULL_END
