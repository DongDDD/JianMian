//
//  JMBUserPostPositionViewController.h
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMBUserPostSaleJobViewTypeAdd,
    JMBUserPostSaleJobViewTypeEdit,
    JMBUserPostSaleJobViewTypeHistory
} JMBUserPostSaleJobViewType;


@interface JMBUserPostSaleJobViewController : BaseViewController

@property(nonatomic, copy)NSString *task_id;//任务主键
@property(nonatomic, assign)JMBUserPostSaleJobViewType viewType;

@end

NS_ASSUME_NONNULL_END
