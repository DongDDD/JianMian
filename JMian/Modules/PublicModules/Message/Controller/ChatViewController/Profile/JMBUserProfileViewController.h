//
//  JMBUserProfileViewController.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, JMBUserProfileViewControllerType) {
    JMBUserProfileView_Type_C2C      = 1,
    JMBUserProfileView_Type_Group    = 2,
    JMBUserProfileView_Type_System   = 3,
    JMBUserProfileView_Type_Service   = 4,
};

@interface JMBUserProfileViewController : UIViewController
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *userIM_id;
@property(nonatomic,assign)BOOL isMyFriend;
@property(nonatomic,assign)JMBUserProfileViewControllerType viewType;

@end

NS_ASSUME_NONNULL_END
