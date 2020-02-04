//
//  JMCSaleTypeDetailStoreHeaderTableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMShopModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMCSaleTypeDetailStoreHeaderTableViewCellIdentifier;

@interface JMCSaleTypeDetailStoreHeaderTableViewCell : UITableViewCell
@property(nonatomic,strong)JMShopModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsCount;


@end

NS_ASSUME_NONNULL_END
