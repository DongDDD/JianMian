//
//  JMCDetailImageTableViewCell.h
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMCDetailImageTableViewCellIdentifier;

@interface JMCDetailImageTableViewCell : UITableViewCell

@property(nonatomic,strong)JMCDetailModel *model;
@property(nonatomic,copy)NSString *url;
@end

NS_ASSUME_NONNULL_END
