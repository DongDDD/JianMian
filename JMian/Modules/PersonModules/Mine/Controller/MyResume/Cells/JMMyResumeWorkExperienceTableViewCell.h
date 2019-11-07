//
//  JMMyResumeWorkExperienceTableViewCell.h
//  JMian
//
//  Created by Chitat on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const JMMyResumeWorkExperienceTableViewCellIdentifier;

@interface JMMyResumeWorkExperienceTableViewCell : UITableViewCell

- (void)setWorkExperienceModel:(JMExperiencesModel *)model;
@end

NS_ASSUME_NONNULL_END
