//
//  JMCUserProfileViewController.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMCUserProfileViewController : UIViewController
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *userIM_id;

@property(nonatomic,assign)BOOL isMyFriend;

@end

NS_ASSUME_NONNULL_END
