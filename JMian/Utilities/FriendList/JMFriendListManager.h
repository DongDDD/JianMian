//
//  JMFriendListManager.h
//  JMian
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCommonContactSelectCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMFriendListManager : NSObject

+(NSMutableArray *)getFriendList;

+(void)saveFriendList:(NSArray<TCommonContactSelectCellData *> *)friends;

@end

NS_ASSUME_NONNULL_END
