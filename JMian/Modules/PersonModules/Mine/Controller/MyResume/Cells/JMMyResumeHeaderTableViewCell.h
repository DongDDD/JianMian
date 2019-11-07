//
//  JMMyResumeHeaderTableViewCell.h
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const JMMyResumeHeaderTableViewCellIdentifier;
extern NSString *const JMMyResumeHeaderSecondTableViewCellIdentifier;
extern NSString *const JMMyResumeHeader2TableViewCellIdentifier;
extern NSString *const JMMyResumeHeader3TableViewCellIdentifier;
extern NSString *const JMMyResumeHeader4TableViewCellIdentifier;

@interface JMMyResumeHeaderTableViewCell : UITableViewCell

- (void)cellConfigWithIdentifier:(NSString *)identifier imageViewName:(NSString *)imageViewName title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
