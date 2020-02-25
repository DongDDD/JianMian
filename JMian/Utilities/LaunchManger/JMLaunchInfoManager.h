//
//  JMSpecialManager.h
//  JMian
//
//  Created by mac on 2020/2/25.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMLaunchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMLaunchInfoManager : NSObject
+ (JMLaunchModel *)getLaunchInInfo;
+ (void)saveVersionInfo:(JMLaunchModel *)model;
@end

NS_ASSUME_NONNULL_END
