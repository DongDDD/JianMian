//
//  JMMyResumeIconTableViewCell.h
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const JMMyResumeIconTableViewCellIdentifier;

@interface JMMyResumeIconTableViewCell : UITableViewCell

- (void)setUserInfo:(JMUserInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
