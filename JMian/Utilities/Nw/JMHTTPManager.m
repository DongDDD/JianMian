//
//  JMHTTPManager.m
//  JMian
//
//  Created by chitat on 2019/3/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"
#import "APIStringMacros.h"

@implementation JMHTTPManager

+ (instancetype)sharedInstance {
    static JMHTTPManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JMHTTPManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL_STRING] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return _manager;
}

@end
