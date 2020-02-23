//
//  JMCSaleTypeDetailStoreHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMCSaleTypeDetailStoreHeaderTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMCSaleTypeDetailStoreHeaderTableViewCellIdentifier = @"JMCSaleTypeDetailStoreHeaderTableViewCellIdentifier";

@implementation JMCSaleTypeDetailStoreHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMShopModel *)model{
    
    self.titleLab.text  = model.shop_name;
}

 

-(void)setValuesWithImageUrl:(NSString *)imageUrl  title:(NSString *)title goodsCount:(NSString *)goodsCount{
//    NSString *url =  [NSString stringWithFormat:@"http://app.jmzhipin.com%@",imageUrl];
       [self.logoImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.titleLab.text  = title;
    self.goodsCount.text = [NSString stringWithFormat:@"在售商品：%@",goodsCount];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
