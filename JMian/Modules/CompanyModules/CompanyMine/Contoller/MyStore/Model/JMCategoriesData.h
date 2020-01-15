//
//  JMCategoriesData.h
//  JMian
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCategoriesData : NSObject
//"sort_id": 4,
//"title": "婚纱/旗袍/礼服",
//"pid": 3,
//"description": null,
//"sort": 50,
//"status": 1,
//"created_at": "2020-01-03 17:05:55",
//"level": 2,
//"children":
@property (copy, nonatomic) NSString *sort_id;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *pid;
@property (copy, nonatomic) NSString *myDescription;
@property (copy, nonatomic) NSString *sort;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *level;
@property (copy, nonatomic) NSArray *children;

@end

NS_ASSUME_NONNULL_END
