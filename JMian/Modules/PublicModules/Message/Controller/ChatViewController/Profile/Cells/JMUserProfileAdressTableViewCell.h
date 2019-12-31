//
//  JMUserProfileAdressTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCompanyInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMUserProfileAdressTableViewCellIdentifier;

@interface JMUserProfileAdressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *adressLab;
@property(nonatomic,strong)JMCompanyInfoModel *model;
@end

NS_ASSUME_NONNULL_END
