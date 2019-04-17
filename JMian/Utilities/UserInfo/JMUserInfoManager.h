//
//  JMUserInfoManager.h
//  JMian
//
//  Created by chitat on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMUserInfoManager : NSObject

+ (JMUserInfoModel *)getUserInfo; //读取用户信息
+ (void)saveUserInfo:(JMUserInfoModel *)model; //保存用户信息

@end

NS_ASSUME_NONNULL_END
