//
//  JMMyStoreTitleHeaderTableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMMyStoreTitleHeaderTableViewCellIdentifier;

@interface JMMyStoreTitleHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;

@end

NS_ASSUME_NONNULL_END
