//
//  JMUserProfilePersonInfoTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMUserProfilePersonInfoTableViewCellIdentifier;

@interface JMUserProfilePersonInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *birthDay;
@property (weak, nonatomic) IBOutlet UILabel *email;
-(void)setBirthDay:(NSString *)birthDay email:(NSString *)email;

@end

NS_ASSUME_NONNULL_END
