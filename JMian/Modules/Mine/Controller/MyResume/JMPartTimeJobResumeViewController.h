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
    JMPartTimeJobTypeResume,
    JMPartTimeJobTypeManage,
} JMPartTimeJobResumeViewType;

@interface JMPartTimeJobResumeViewController : BaseViewController
@property (nonatomic, assign)JMPartTimeJobResumeViewType viewType;

@end

NS_ASSUME_NONNULL_END
