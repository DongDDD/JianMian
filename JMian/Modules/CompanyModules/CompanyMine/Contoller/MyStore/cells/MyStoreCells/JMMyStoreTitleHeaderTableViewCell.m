//
//  JMMyStoreTitleHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMMyStoreTitleHeaderTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMMyStoreTitleHeaderTableViewCellIdentifier = @"JMMyStoreTitleHeaderTableViewCellIdentifier";

@implementation JMMyStoreTitleHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMShopInfoModel *)model{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.shop_logo] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.storeNameLab.text = model.shop_name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
