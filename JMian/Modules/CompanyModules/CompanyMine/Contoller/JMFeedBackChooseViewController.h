//
//  JMFeedBackChooseViewController.h
//  JMian
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMFeedBackChooseViewDefault,
    JMFeedBackChooseViewAppdelegate,
} JMFeedBackChooseViewType;


@protocol JMFeedBackChooseViewControllerDelegate <NSObject>

-(void)didCommitActionWithInterview_id:(NSString *)interview_id;

@end

@interface JMFeedBackChooseViewController : BaseViewController

@property(nonatomic,copy)NSString *interview_id;
@property(nonatomic,assign)id<JMFeedBackChooseViewControllerDelegate>delegate;
@property(nonatomic,assign)JMFeedBackChooseViewType viewType;
@end

NS_ASSUME_NONNULL_END
