//
//  JMOrderInfoHeaderTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOrderInfoHeaderTableViewCellIdentifier;

@interface JMOrderInfoHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

NS_ASSUME_NONNULL_END
