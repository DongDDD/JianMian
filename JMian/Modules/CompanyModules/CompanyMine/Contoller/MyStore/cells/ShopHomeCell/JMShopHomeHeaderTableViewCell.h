//
//  JMShopHomeHeaderTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMShopHomeHeaderTableViewCellIdentifier;

@interface JMShopHomeHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsCount;
-(void)setValuesWithImageUrl:(NSString *)imageUrl shopName:(NSString *)shopName goodsCount:(NSString *)goodsCount;
@end

NS_ASSUME_NONNULL_END
