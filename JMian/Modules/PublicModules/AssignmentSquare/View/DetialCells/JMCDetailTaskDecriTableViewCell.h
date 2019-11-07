//
//  JMCDetailTaskDecriTableViewCell.h
//  JMian
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMCDetailTaskDecriTableViewCellIdentifier;

@interface JMCDetailTaskDecriTableViewCell : UITableViewCell

@property(nonatomic,strong)JMCDetailModel *model;
@end

NS_ASSUME_NONNULL_END
