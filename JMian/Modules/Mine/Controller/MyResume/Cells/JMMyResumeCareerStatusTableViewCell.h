//
//  JMMyResumeCareerStatusTableViewCell.h
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const JMMyResumeCareerStatusTableViewCellIdentifier;
extern NSString *const JMMyResumeCareerStatus2TableViewCellIdentifier;

@interface JMMyResumeCareerStatusTableViewCell : UITableViewCell

- (void)setWorkStatus:(NSString *)workStatus;
@end

NS_ASSUME_NONNULL_END
