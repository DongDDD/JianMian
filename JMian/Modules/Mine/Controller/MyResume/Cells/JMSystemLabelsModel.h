//
//  JMSystemLabelsModel.h
//  JMian
//
//  Created by Chitat on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMSystemLabelsModel : NSObject

@property (nonatomic, copy) NSString *label_id;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *is_enabled;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, strong) NSArray *pid_relation;


@end

NS_ASSUME_NONNULL_END
