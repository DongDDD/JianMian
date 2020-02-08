//
//  JMStroreNotificationViewController.h
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMStroreNotificationViewPoster,
    JMStroreNotificationViewDesc,
} JMStroreNotificationViewType;

@interface JMStroreNotificationViewController : BaseViewController
@property(nonatomic,copy)NSString *content;
@property(nonatomic,assign)JMStroreNotificationViewType viewType;
@end

NS_ASSUME_NONNULL_END
