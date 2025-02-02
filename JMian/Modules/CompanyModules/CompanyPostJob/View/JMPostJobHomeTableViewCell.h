//
//  JMPostJobHomeTableViewCell.h
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMHomeWorkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMPostJobHomeTableViewCell : UITableViewCell

@property (nonatomic, strong)JMHomeWorkModel *model;
@property (weak, nonatomic) IBOutlet UILabel *workNameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;

@end

NS_ASSUME_NONNULL_END
