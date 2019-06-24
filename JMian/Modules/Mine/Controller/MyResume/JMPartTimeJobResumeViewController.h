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
@protocol JMPartTimeJobResumeViewControllerDelegate <NSObject>

-(void)postPartTimeJobAction;

@end

@interface JMPartTimeJobResumeViewController : BaseViewController
@property (nonatomic, assign)JMPartTimeJobResumeViewType viewType;
@property (nonatomic, weak)id<JMPartTimeJobResumeViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
