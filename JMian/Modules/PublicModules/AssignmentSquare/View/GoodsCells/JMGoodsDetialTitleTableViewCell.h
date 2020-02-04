//
//  JMGoodsDetialTitleTableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMGoodsInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMGoodsDetialTitleTableViewCellIdentifier;

@interface JMGoodsDetialTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *salarylab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property(nonatomic,strong)JMGoodsInfoModel *model;
@end

NS_ASSUME_NONNULL_END
