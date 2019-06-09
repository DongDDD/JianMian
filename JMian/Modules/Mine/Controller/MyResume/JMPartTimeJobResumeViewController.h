//
//  JMPartTimeJobResumeViewController.h
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMPartTimeJobTypeDefault,
    JMPartTimeJobTypeManage,
} JMPartTimeJobViewType;

@interface JMPartTimeJobResumeViewController : BaseViewController
@property (nonatomic, assign)JMPartTimeJobViewType viewType;

@end

NS_ASSUME_NONNULL_END
