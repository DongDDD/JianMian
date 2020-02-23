//
//  JMShopHomeHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMShopHomeHeaderTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMShopHomeHeaderTableViewCellIdentifier = @"JMShopHomeHeaderTableViewCellIdentifier";

@implementation JMShopHomeHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setValuesWithImageUrl:(NSString *)imageUrl shopName:(NSString *)shopName goodsCount:(NSString *)goodsCount{
//    NSString *url = [NSString stringWithFormat:@"http://app.jmzhipin.com%@",imageUrl];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.shopNameLab.text = shopName;
    self.goodsCount.text = [NSString stringWithFormat:@"在售商品:%@",goodsCount];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
