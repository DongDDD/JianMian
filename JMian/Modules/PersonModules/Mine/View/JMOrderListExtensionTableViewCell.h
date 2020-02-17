//
//  JMOrderListExtensionTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMOrderCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMOrderListExtensionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *statusRightTopLab;
@property (weak, nonatomic) IBOutlet UIImageView *didSendGoodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property(nonatomic,strong)JMOrderCellData *orderCellData;

@end

NS_ASSUME_NONNULL_END
