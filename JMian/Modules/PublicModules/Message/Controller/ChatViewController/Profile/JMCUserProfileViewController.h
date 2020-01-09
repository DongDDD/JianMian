//
//  JMCUserProfileViewController.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, JMCUserProfileViewControllerType) {
    JMCUserProfileView_Type_C2C      = 1,
    JMCUserProfileView_Type_Group    = 2,
    JMCUserProfileView_Type_System   = 3,
    JMCUserProfileView_Type_Service   = 4,
    JMCUserProfileView_Type_Video   = 5,

};

@interface JMCUserProfileViewController : BaseViewController
@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,assign)BOOL isMyFriend;
@property(nonatomic,assign)JMCUserProfileViewControllerType viewType;

@end

NS_ASSUME_NONNULL_END
