//
//  JMComDetailContentTableViewCell.h
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCompanyInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMComDetailContentTableViewCellIdentifier;

@interface JMComDetailContentTableViewCell : UITableViewCell

@property(nonatomic,strong)JMCompanyInfoModel *model;
@end

NS_ASSUME_NONNULL_END
