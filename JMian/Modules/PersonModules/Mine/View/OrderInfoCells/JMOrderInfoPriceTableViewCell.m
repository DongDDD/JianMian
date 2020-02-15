//
//  JMOrderInfoPriceTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderInfoPriceTableViewCell.h"
NSString *const JMOrderInfoPriceTableViewCellIdentifier = @"JMOrderInfoPriceTableViewCellIdentifier";

@implementation JMOrderInfoPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPrice:(NSString *)price{
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
