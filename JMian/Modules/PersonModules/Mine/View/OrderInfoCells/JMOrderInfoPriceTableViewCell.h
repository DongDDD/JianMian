//
//  JMOrderInfoPriceTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOrderInfoPriceTableViewCellIdentifier;

@interface JMOrderInfoPriceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (copy, nonatomic) NSString *price;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

NS_ASSUME_NONNULL_END
