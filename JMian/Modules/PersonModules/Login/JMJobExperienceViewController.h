//
//  JMJobExperienceViewController.h
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMJobExperienceViewType) {
    JMJobExperienceViewTypeDefault,
    JMJobExperienceViewTypeEdit,
    JMJobExperienceViewTypeAdd,
};

@interface JMJobExperienceViewController : BaseViewController

@property (assign, nonatomic) JMJobExperienceViewType viewType;
@property (strong, nonatomic) JMExperiencesModel *model;


@end

NS_ASSUME_NONNULL_END
