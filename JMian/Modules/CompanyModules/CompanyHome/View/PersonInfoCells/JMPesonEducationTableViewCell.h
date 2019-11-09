//
//  JMPesonEducationTableViewCell.h
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMPesonEducationTableViewCellIdentifier;

@interface JMPesonEducationTableViewCell : UITableViewCell
@property(nonatomic, strong)JMEducationModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab2;

@end

NS_ASSUME_NONNULL_END
