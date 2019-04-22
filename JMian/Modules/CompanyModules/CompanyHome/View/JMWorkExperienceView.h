//
//  JMWorkExperienceView.h
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMWorkExperienceView : UIView

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic ,strong) JMExperiencesModel *model;

@end

NS_ASSUME_NONNULL_END
