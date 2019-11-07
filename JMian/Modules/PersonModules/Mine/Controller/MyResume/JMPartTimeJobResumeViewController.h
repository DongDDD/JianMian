//
//  JMPartTimeJobResumeViewController.h
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMTaskListCellData.h"
#import "JMAbilityCellData.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMPartTimeJobTypeResume,
    JMPartTimeJobTypeManage,
    JMPartTimeJobTypeHome,
    JMPartTimeJobTypeHistory,
} JMPartTimeJobResumeViewType;
@protocol JMPartTimeJobResumeViewControllerDelegate <NSObject>

-(void)postPartTimeJobAction;
-(void)didClickCellWithAbilityData:(JMAbilityCellData *)abilityData;
-(void)didClickCellWithTaskData:(JMTaskListCellData *)taskData;

@end

@interface JMPartTimeJobResumeViewController : BaseViewController
@property (nonatomic, assign)JMPartTimeJobResumeViewType viewType;
@property (nonatomic, weak)id<JMPartTimeJobResumeViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
