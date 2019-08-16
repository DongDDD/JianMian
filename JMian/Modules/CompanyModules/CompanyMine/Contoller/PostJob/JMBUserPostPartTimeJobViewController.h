//
//  JMBUserPostPartTimeJobViewController.h
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMBUserPostPartTimeJobTypeAdd,
    JMBUserPostPartTimeJobTypeEdit,
    JMBUserPostPartTimeJobTypeHistory,
} JMBUserPostPartTimeJobViewType;

@interface JMBUserPostPartTimeJobViewController : BaseViewController

@property(nonatomic, copy)NSString *task_id;////任务主键
@property(nonatomic, assign)JMBUserPostPartTimeJobViewType viewType;

@end

NS_ASSUME_NONNULL_END
