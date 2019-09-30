//
//  JMNoDataTableViewCell.h
//  JMian
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMNoDataTableViewCellIdentifier;

@interface JMNoDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

NS_ASSUME_NONNULL_END
