//
//  JMScrollviewTableViewCell.h
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCompanyInfoModel.h"
#import "JMGoodsInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMScrollviewTableViewCellIdentifier;

@interface JMScrollviewTableViewCell : UITableViewCell
//@property(nonatomic,strong)JMCompanyInfoModel *model;
//@property(nonatomic,strong)JMGoodsInfoModel *goodsInfoModel;
@property(nonatomic,strong)NSArray *imagesArr;
@end

NS_ASSUME_NONNULL_END
