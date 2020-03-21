//
//  JMGoodsInfoTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMOrderCellData.h"
NS_ASSUME_NONNULL_BEGIN

extern NSString *const JMGoodsInfoTableViewCellIdentifier;

@interface JMGoodsInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
@property (weak, nonatomic) IBOutlet UILabel *titleLab3;
@property (weak, nonatomic) IBOutlet UILabel *titleLab4;
@property (nonatomic, strong) JMGoodsInfoCellData *data;
-(void)setValuesWithImageUrl:(NSString *)ImageUrl title:(NSString *)title quantity:(NSString *)quantity  price:(NSString *)price sku_mark:(NSString *)sku_mark;
@end

NS_ASSUME_NONNULL_END
