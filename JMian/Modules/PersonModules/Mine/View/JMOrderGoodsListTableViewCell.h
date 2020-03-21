//
//  JMOrderGoddsListTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOrderGoodsListTableViewCellIdentifier;

@interface JMOrderGoodsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *quantityLab;
@property (weak, nonatomic) IBOutlet UILabel *sku_markLab;
-(void)setValuesWithImageUrl:(NSString *)imageUrl title:(NSString *)title price:(NSString *)price quantity:(NSString *)quantity sku_mark:(NSString *)sku_mark;
@end

NS_ASSUME_NONNULL_END
