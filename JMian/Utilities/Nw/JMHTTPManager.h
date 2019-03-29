//
//  JMHTTPManager.h
//  JMian
//
//  Created by chitat on 2019/3/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager : AFHTTPSessionManager

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
