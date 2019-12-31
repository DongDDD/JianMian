//
//  JMGroupIntroduceViewController.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class JMGroupIntroduceViewController;
@protocol JMGroupIntroduceViewControllerDelegate <NSObject>
- (void)groupIntroduceController:(JMGroupIntroduceViewController *)modifyView didModiyContent:(NSString *)content;

@end
@interface JMGroupIntroduceViewController : BaseViewController
@property(nonatomic,copy)NSString *groupIntroduce;
@property(nonatomic,weak)id<JMGroupIntroduceViewControllerDelegate>delegate;
@property(nonatomic,assign)BOOL isMeOwner;
@end

NS_ASSUME_NONNULL_END
