//
//  JMGroupNameViewController.h
//  JMian
//
//  Created by mac on 2020/1/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class JMGroupNameViewController;
@protocol JMGroupNameViewControllerDelegate <NSObject>
- (void)groupNameController:(JMGroupNameViewController *)modifyView didModiyContent:(NSString *)content;
@end
@interface JMGroupNameViewController : BaseViewController
@property(nonatomic,copy)NSString *groupName;

@property(nonatomic,weak)id<JMGroupNameViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
