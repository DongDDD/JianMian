//
//  BasicInformationViewController.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JMUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasicInformationViewController : BaseViewController

@property (strong, nonatomic) JMUserInfoModel *model;

@end

NS_ASSUME_NONNULL_END
