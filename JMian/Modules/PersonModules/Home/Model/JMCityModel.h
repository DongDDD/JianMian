//
//  JMCityModel.h
//  JMian
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCityModel : NSObject


@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSArray *children;

@end

NS_ASSUME_NONNULL_END
