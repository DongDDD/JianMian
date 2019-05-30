//
//  JMEducationalExperienceTableViewCell.h
//  JMian
//
//  Created by Chitat on 2019/4/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const JMEducationalExperienceTableViewCellIdentifier;

@interface JMEducationalExperienceTableViewCell : UITableViewCell

- (void)setEducationExperienceModel:(JMLearningModel *)model;

@end

NS_ASSUME_NONNULL_END
