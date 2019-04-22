//
//  JMCompanyHomeTableViewCell.h
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCompanyHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMCompanyHomeTableViewCell : UITableViewCell

@property(nonatomic,strong)JMCompanyHomeModel *model;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property (weak, nonatomic) IBOutlet UILabel *experinenceLab;
@property (weak, nonatomic) IBOutlet UILabel *educationLab;
@property (weak, nonatomic) IBOutlet UILabel *jobDetailLab;

@end

NS_ASSUME_NONNULL_END
