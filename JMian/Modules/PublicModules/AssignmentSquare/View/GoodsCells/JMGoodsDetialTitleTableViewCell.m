//
//  JMGoodsDetialTitleTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsDetialTitleTableViewCell.h"
NSString *const JMGoodsDetialTitleTableViewCellIdentifier = @"JMGoodsDetialTitleTableViewCellIdentifier";

@implementation JMGoodsDetialTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMGoodsInfoModel *)model{
    self.titleLab.text = model.title;
    self.priceLab.text = model.price;
    self.salarylab.text = [NSString stringWithFormat:@"佣金: ¥%@",model.salary];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
