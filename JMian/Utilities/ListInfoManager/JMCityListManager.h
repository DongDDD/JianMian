//
//  JMCityListManager.h
//  JMian
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCityListManager : NSObject
+ (id)getCityListInfo;
+ (void)saveCityListData:(NSArray *)listArray;
@end

NS_ASSUME_NONNULL_END
