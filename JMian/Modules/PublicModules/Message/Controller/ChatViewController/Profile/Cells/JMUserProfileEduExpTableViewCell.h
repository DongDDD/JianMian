//
//  JMUserProfileEduExpTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMUserProfileEduExpTableViewCellIdentifier;

@interface JMUserProfileEduExpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLab;
@property (weak, nonatomic) IBOutlet UILabel *majorLab;
@property (weak, nonatomic) IBOutlet UILabel *eduLab;
@property(nonatomic,strong)JMVitaDetailModel *model;
@end

NS_ASSUME_NONNULL_END
