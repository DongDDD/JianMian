//
//  JMEducationExperienceViewController.h
//  JMian
//
//  Created by chitat on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, JMEducationExperienceViewType) {
    JMEducationExperienceViewTypeEdit,
    JMEducationExperienceViewTypeAdd,
};
@interface JMEducationExperienceViewController : BaseViewController

@property (assign, nonatomic) JMEducationExperienceViewType viewType;
@property (strong, nonatomic) JMLearningModel *model;

@end

NS_ASSUME_NONNULL_END
