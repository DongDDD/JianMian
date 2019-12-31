//
//  JMUserProfileIntroduceTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMUserProfileIntroduceTableViewCellIdentifier;

@interface JMUserProfileIntroduceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;
@property(nonatomic,copy)NSString *introduceStr;
@end

NS_ASSUME_NONNULL_END
