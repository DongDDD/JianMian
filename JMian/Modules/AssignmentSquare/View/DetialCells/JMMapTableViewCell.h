//
//  JMMapTableViewCell.h
//  JMian
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMMapTableViewCellIdentifier;

@interface JMMapTableViewCell : UITableViewCell
@property(nonatomic,strong)JMCDetailModel *model;
@end

NS_ASSUME_NONNULL_END
