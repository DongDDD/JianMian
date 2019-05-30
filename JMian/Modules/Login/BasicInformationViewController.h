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
typedef NS_ENUM(NSInteger, BasicInformationViewType) {
    BasicInformationViewTypeDefault,
    BasicInformationViewTypeEdit,
};


@interface BasicInformationViewController : BaseViewController

@property (strong, nonatomic)JMUserInfoModel *model;
@property (assign, nonatomic)BasicInformationViewType viewType;
@end

NS_ASSUME_NONNULL_END
