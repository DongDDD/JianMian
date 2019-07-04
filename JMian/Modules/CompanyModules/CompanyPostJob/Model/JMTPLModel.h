//
//  JMTPLModel.h
//  JMian
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMTPLModel : NSObject
@property(nonatomic, copy)NSString *tpl_id;
@property(nonatomic, copy)NSString *foreign_key;
@property(nonatomic, copy)NSString *type;
@property(nonatomic, copy)NSString *myTemplate;

@end

NS_ASSUME_NONNULL_END
