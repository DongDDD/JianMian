//
//  JMPersonHeaderTableViewCell.h
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMPersonHeaderTableViewCellIdentifier;

@interface JMPersonHeaderTableViewCell : UITableViewCell
@property(nonatomic,strong)JMVitaDetailModel *model;
@end

NS_ASSUME_NONNULL_END
