//
//  JMGreetModel.h
//  JMian
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMGreetModel : NSObject
@property (nonatomic, copy) NSString *greet_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *mode;
@property (nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
