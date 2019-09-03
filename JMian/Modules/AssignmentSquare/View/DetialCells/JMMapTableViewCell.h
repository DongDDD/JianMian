//
//  JMMapTableViewCell.h
//  JMian
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCDetailModel.h"
#import "JMCompanyInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMMapTableViewCellIdentifier;

@interface JMMapTableViewCell : UITableViewCell
@property(nonatomic,strong)JMCDetailModel *model;
@property(nonatomic,strong)JMCompanyInfoModel *comModel;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *address;

@end

NS_ASSUME_NONNULL_END
