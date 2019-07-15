//
//  JMVersionManager.h
//  JMian
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMVersionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMVersionManager : NSObject
+ (JMVersionModel *)getVersoinInfo;
+ (void)saveVersionInfo:(JMVersionModel *)model;
@end

NS_ASSUME_NONNULL_END
