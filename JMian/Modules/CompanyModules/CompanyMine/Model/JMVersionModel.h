//
//  JMVersionModel.h
//  JMian
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMVersionModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *test;
@property (nonatomic, copy) NSString *v_id;
@property (nonatomic, copy) NSString *enforce;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *appDescription;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
