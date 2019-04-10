//
//  JMHTTPRequest.h
//  JMian
//
//  Created by chitat on 2019/3/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMRequestMethod) {
    JMRequestMethodGET = 0,
    JMRequestMethodPOST,
    JMKRequestMethodHEAD,
    JMRequestMethodPUT,
    JMRequestMethodDELETE,
    JMRequestMethodPATCH,
    JMRequestMethodUpload,
};


@interface JMHTTPRequest : NSObject

typedef void(^JMHTTPRequestCompletionSuccessBlock)(JMHTTPRequest *request,id responsObject);
typedef void(^JMHTTPRequestCompletionFailureBlock)(JMHTTPRequest *request,id error);

/// 路径 （v14/order）
@property (nonatomic, readwrite, strong) NSString *path;
/// 参数列表
@property (nonatomic, readwrite, strong) NSDictionary *parameters;
/// 方法
@property (nonatomic, readwrite, assign) JMRequestMethod method;

//成功回调
@property (nonatomic, readwrite, copy) JMHTTPRequestCompletionSuccessBlock successBlock;
//失败回调
@property (nonatomic, readwrite, copy) JMHTTPRequestCompletionFailureBlock failureBlock;

+ (instancetype)urlParametersWithMethod:(JMRequestMethod)method path:(NSString *)path parameters:(nullable NSDictionary *)parameters;

- (void)sendRequestWithCompletionBlockWithSuccess:(JMHTTPRequestCompletionSuccessBlock)success  failure:(JMHTTPRequestCompletionFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
